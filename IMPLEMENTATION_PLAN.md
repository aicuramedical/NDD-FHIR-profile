# AICURA FHIR Implementation Guide — Implementation Plan

> **Plan version**: v3 (post-iteration-2, all 5 iteration-2 fixes folded in)
> **Diff from v2**: `git diff iteration/2-pre-fixes..iteration/2 -- IMPLEMENTATION_PLAN.md`

## Context

AICURA's Apollo service (`aicura/os/apollo`) implements a FHIR-based data model via GraphQL/Neo4j with 18+ resources and custom extensions (especially for medical imaging). This data model exists only as GraphQL schemas and JavaScript code — there is no formal FHIR IG. We need to create an externally-publishable FHIR R4B Implementation Guide that formally profiles the resources and extensions Apollo implements, using FSH (FHIR Shorthand) + SUSHI + HL7 IG Publisher.

**Target directory:** `/workspaces/project/aicura/research/ig-publisher`

## Decisions

- **FHIR version:** R4B (4.3.0)
- **Initial resources:** ImagingStudy (with series extensions), Observation, Condition
- **Deferred:** ResearchStudy, ResearchSubject (no data samples yet)
- **Dependencies:** Base FHIR only — do NOT list `hl7.fhir.r4b.core` in `dependencies` (it is inferred from `fhirVersion`)
- **Canonical URL:** `http://aicuramedical.com/fhir`
- **Authoring:** FSH → SUSHI → IG Publisher
- **Build prerequisites:** Node.js (SUSHI), Java 17+ (IG Publisher), Ruby + Jekyll (`fhir.base.template` requires Jekyll for HTML assembly)

## Data Sources

- `data-samples/unique_imagingSeries.csv` — 1757 imaging series (MR + PET)
- `data-samples/unique_observations.csv` — 102 observations (assessments, labs, genetics)
- `data-samples/unique_conditions.csv` — 69 conditions (neurological focus)
- `data-integration/concepts/` — full coding systems (SNOMED-CT, LOINC, AICURA custom, PubChem, MedDRA)

## Target Directory Structure

```
ig-publisher/
├── sushi-config.yaml
├── ig.ini
├── .gitignore
├── input/
│   ├── fsh/
│   │   ├── aliases.fsh
│   │   ├── rs-metadata.fsh
│   │   ├── ext-*.fsh              # 15 extension definitions
│   │   ├── p-*.fsh                # 3 profile definitions
│   │   ├── cs-*.fsh               # CodeSystems (AICURA custom codings)
│   │   ├── vs-*.fsh               # ValueSets
│   │   └── examples/
│   ├── pagecontent/
│   │   ├── index.md
│   │   ├── profiles.md
│   │   ├── extensions.md
│   │   └── downloads.md
│   └── ignoreWarnings.txt
├── data-samples/                  # CSV data samples
├── FIXES.md
└── METRICS.md
```

## Test Layers

| Layer | Test | Pass criteria |
|-------|------|---------------|
| Structure | Files exist per directory structure above | All files present |
| Compilation | `sushi .` | 0 errors, 0 warnings |
| Build | `java -jar input-cache/publisher.jar -ig .` | Exit code 0 |
| QA: XHTML validity | `output/qa.html` | 0 invalid pages |
| QA: Validation errors | `output/qa.min.html` | 0 errors in StructureDefinitions/terminology |
| QA: Overall errors | `output/qa.min.html` | 11 errors (all non-suppressible structural — see Phase 5) |
| QA: Overall warnings | `output/qa.html` | ≤1 warning (excluding known suppressed) |
| Verification | Extension URLs match Apollo production | 15/15 match |
| Verification | Profile ValueSet bindings | 3/3 profiles bound |

## Implementation Phases

### Phase 0: Prerequisites

> *Added from iteration 1 fix: "Jekyll not installed for template rendering"*

**Goal**: Ensure all build tools are available.
**Inputs**: Dev container with Node.js 20+, Java 17+.
**Operations**:
1. Verify SUSHI is installed: `which sushi && sushi --version` (expect v3.x). If not installed: `sudo npm install -g fsh-sushi`
2. Verify Java: `java -version` (expect 17+)
3. Install Ruby and Jekyll if not present: `sudo apt-get install -y ruby-full build-essential && sudo gem install jekyll`
4. Verify: `jekyll --version`

**Validation checkpoint**: All four commands succeed.
**Known risks**: Jekyll gem install may need `sudo`. Ruby version must be >= 2.7 for Jekyll 4.x.

### Phase 1: Scaffold

**Goal**: Minimal IG skeleton that compiles with SUSHI.
**Inputs**: Phase 0 complete.
**Operations**:
1. Create directory structure: `input/fsh/examples/`, `input/pagecontent/`
2. Create `sushi-config.yaml` with:
   - `id: aicura.fhir.ig`, `canonical: http://aicuramedical.com/fhir`
   - `fhirVersion: 4.3.0`
   - **No `dependencies` block** — the core package is inferred from `fhirVersion`. Listing `hl7.fhir.r4b.core` explicitly causes IG Publisher to crash with `JsonException: Name already exists`.
   - `pages` section must include `downloads.md` (not `downloads.xml`)
   - `menu` section: Home, Profiles, Extensions, Artifacts, Downloads
3. Create `ig.ini`: `ig = fsh-generated/resources/ImplementationGuide-aicura.fhir.ig.json`, `template = fhir.base.template`
4. Create `.gitignore`: `fsh-generated/`, `output/`, `temp/`, `template/`, `input-cache/`, `*.jar`
5. Create `aliases.fsh` with aliases for: `$SCT`, `$LOINC`, `$UCUM`, `$DICOM`, `$ObsCat`, `$CondCat`, `$CondClinical`, `$CondVerStatus`, `$AicuraCoding`, `$AicuraSD`, `$PubChem`, `$DICOMModality`, `$MedDRA`
6. Create `rs-metadata.fsh` with RuleSets: `MetaProfile(profile)`, `ExtensionContext(path)`

**Validation checkpoint**: `sushi .` → 0 errors, 0 warnings, 0 definitions (scaffold only).
**Known risks**: None — this is well-tested from iteration 1.

### Phase 2: Extensions (15 ImagingStudy.series extensions)

**Goal**: Define all 15 series-level extensions matching Apollo production URLs exactly.
**Inputs**: Phase 1 complete.
**Operations**: Create one FSH file per extension. Each must set `^url` to match the corresponding URL from `aicura/os/apollo/src/extension/fhir_imagingstudy_extension.js` and use `insert ExtensionContext(ImagingStudy.series)`.

| Extension | Apollo URL suffix | Type | FSH file |
|-----------|-------------------|------|----------|
| VoxelResolution | `/VoxelResolution` | Complex (X/Y/Z decimal + comparator/unit/system/code) | `ext-voxel-resolution.fsh` |
| ImageResolution | `/ImageResolution` | Complex (X/Y/Z integer) | `ext-image-resolution.fsh` |
| IsotropicVoxelResolution | `/IsotropicVoxelResolution` | Boolean | `ext-isotropic-voxel-resolution.fsh` |
| IsotropicImageResolution | `/IsotropicImageResolution` | Boolean | `ext-isotropic-image-resolution.fsh` |
| MagneticFieldStrength | `/MagneticFieldStrength` | Decimal | `ext-magnetic-field-strength.fsh` |
| Echotime | `/Echotime` | Decimal | `ext-echotime.fsh` |
| NumberOfFrames | `/NumberOfFrames` | Integer | `ext-number-of-frames.fsh` |
| DeviceManufacturer | `/DeviceManufacturer` | CodeableConcept | `ext-device-manufacturer.fsh` |
| DeviceModel | `/device-model` | CodeableConcept | `ext-device-model.fsh` |
| DeviceId | `/DeviceId` | String | `ext-device-id.fsh` |
| SeriesSequence | `/SeriesSequence` | CodeableConcept | `ext-series-sequence.fsh` |
| Tracer | `/Tracer` | CodeableConcept | `ext-tracer.fsh` |
| Contrast | `/Contrast` | CodeableConcept | `ext-contrast.fsh` |
| AcquisitionPlane | `/AcquisitionPlane` | CodeableConcept | `ext-acquisition-plane.fsh` |
| Dimension | `/Dimension` | CodeableConcept | `ext-dimension.fsh` |

**Not included**: AgeAtImagingStudy, AgeAtImagingSeries, SeriesDerivedFrom, ImagingSeriesSize (out of scope for initial profiles).

**Validation checkpoint**: `sushi .` → 15 extensions, 0 errors.
**Known risks**: VoxelResolution complex extension has 7 sub-extensions — verify SUSHI generates correct nested structure.

### Phase 3: Terminology

**Goal**: Define all CodeSystems and ValueSets needed by the three profiles.
**Inputs**: Phase 2 complete, CSV files from `data-integration/concepts/`.
**Operations**:

#### 3a: Imaging CodeSystems (AICURA custom)

| CodeSystem | Source CSV | Codes | FSH file |
|------------|-----------|-------|----------|
| `aicura-mri-sequence` | `codings/imaging/mri_sequences.csv` | 10 (MPRAGE, TSE, FSE, etc.) | `cs-mri-sequence.fsh` |
| `aicura-mri-contrast` | `codings/imaging/mri_contrasts.csv` | 8 (T1w, T2w FLAIR, etc.) | `cs-mri-contrast.fsh` |
| `aicura-device-manufacturer` | `codings/imaging/device_manufacturer.csv` | 8 (Siemens, GE, Philips, etc.) | `cs-device-manufacturer.fsh` |
| `aicura-dimension` | `codings/imaging/dimension.csv` | 2 (2D, 3D) | `cs-dimension.fsh` |

All use system URL `https://aicuramedical.com/fhir/coding/{name}`, version `1.0`, `caseSensitive = true`, `experimental = false`, `content = #complete`.

#### 3b: Observation CodeSystem (AICURA custom)

> *Added from iteration 1 fix: "Missing ValueSets for Condition and Observation codes"*

| CodeSystem | Source CSV | Codes | FSH file |
|------------|-----------|-------|----------|
| `aicura-observation` | `observations.csv` (rows where `code.coding.system = https://aicuramedical.com/fhir/coding`) | 39 (CDR, NPI-Q, Wechsler, BDNF, MDS-UPDRS, etc.) | `cs-observation.fsh` |

System URL: `https://aicuramedical.com/fhir/coding/observation`, `experimental = false`. Use the `code.coding.code` column as the FSH code and `code.coding.display` as the display. Codes that contain spaces or special characters must be quoted in FSH (e.g., `#"Global score [CDR]"`).

#### 3c: Imaging ValueSets

All ValueSets must include `* ^experimental = false`.

| ValueSet | Content | FSH file |
|----------|---------|----------|
| `aicura-mri-sequence` | All codes from `aicura-mri-sequence` CS | `vs-mri-sequence.fsh` |
| `aicura-mri-contrast` | All codes from `aicura-mri-contrast` CS | `vs-mri-contrast.fsh` |
| `aicura-device-manufacturer` | All codes from `aicura-device-manufacturer` CS | `vs-device-manufacturer.fsh` |
| `aicura-dimension` | All codes from `aicura-dimension` CS | `vs-dimension.fsh` |
| `aicura-acquisition-plane` | SNOMED-CT: 24422004 Axial, 30730003 Sagittal, 81654009 Coronal | `vs-acquisition-plane.fsh` |
| `aicura-imaging-modality` | DICOM: MR, PT, CT, NM | `vs-imaging-modality.fsh` |
| `aicura-pet-tracer` | PubChem CIDs + AICURA `Unresolved-Tracer-Label` | `vs-pet-tracer.fsh` |

#### 3d: Condition and Observation ValueSets

> *Added from iteration 1 fix: "Missing ValueSets for Condition and Observation codes"*

| ValueSet | Content | FSH file |
|----------|---------|----------|
| `aicura-condition-code` | SNOMED-CT (39 codes), AICURA custom (3 codes), MedDRA (10 codes), LOINC (5 codes) — all from `conditions.csv` | `vs-condition-code.fsh` |
| `aicura-observation-code` | LOINC (170 codes) + AICURA custom CS (39 codes) + SNOMED-CT (3 codes) — all from `observations.csv` | `vs-observation-code.fsh` |

For `vs-condition-code.fsh`: enumerate codes per system using `$SCT#code "display"`, `$AicuraCoding#code "display"`, `$MedDRA#code "display"`, `$LOINC#code "display"`.

For `vs-observation-code.fsh`: include all codes from `AicuraObservationCS` plus enumerate the LOINC and SNOMED-CT codes from `observations.csv`.

**Validation checkpoint**: `sushi .` → 5 CodeSystems, 9 ValueSets, 0 errors.
**Known risks**: Codes with special characters (brackets, slashes, asterisks) need FSH quoting. MedDRA system URL `https://www.meddra.org/` may trigger tx.fhir.org warnings — add to `ignoreWarnings.txt`.

### Phase 4: Profiles (3 definitions)

**Goal**: Define constrained profiles with must-support elements and ValueSet bindings.
**Inputs**: Phase 3 complete.
**Operations**:

**`p-imaging-study.fsh` — AicuraImagingStudy**
- Parent: ImagingStudy
- Must-support: status, subject, started, description, series
- Series backbone: uid, modality, description, numberOfInstances, bodySite, laterality
- All 15 extensions on `series.extension` (named slices, all 0..1)
- Must-support on key extensions: voxelResolution, imageResolution, magneticFieldStrength, seriesSequence, contrast, acquisitionPlane, dimension
- **ValueSet bindings on CodeableConcept extensions** (all `extensible`):
  - `series.extension[seriesSequence].value[x] from AicuraMRISequenceVS (extensible)`
  - `series.extension[contrast].value[x] from AicuraMRIContrastVS (extensible)`
  - `series.extension[deviceManufacturer].value[x] from AicuraDeviceManufacturerVS (extensible)`
  - `series.extension[tracer].value[x] from AicuraPETTracerVS (extensible)`
  - `series.extension[acquisitionPlane].value[x] from AicuraAcquisitionPlaneVS (extensible)`
  - `series.extension[dimension].value[x] from AicuraDimensionVS (extensible)`
- Source: `apollo/schemas/core.graphql:105-169`

**`p-observation.fsh` — AicuraObservation**
- Parent: Observation
- Must-support: status, category, code, subject(→Patient), encounter, effective[x], value[x], performer, derivedFrom, component, bodySite, interpretation, method
- **ValueSet bindings**:
  - `code from AicuraObservationCodeVS (extensible)`
- No custom extensions in this iteration
- Source: `apollo/schemas/core.graphql:182-233`

**`p-condition.fsh` — AicuraCondition**
- Parent: Condition
- Must-support: clinicalStatus, verificationStatus, category, severity, code, bodySite, subject(→Patient), encounter, onset[x], abatement[x], recordedDate, stage, evidence
- **ValueSet bindings**:
  - `code from AicuraConditionCodeVS (extensible)`
- No custom extensions in this iteration
- Source: `apollo/schemas/core.graphql:392-427`

**Validation checkpoint**: `sushi .` → 3 profiles + 15 extensions + 5 CS + 9 VS = 32 resources, 0 errors.
**Known risks**: Extension ValueSet bindings use a path through named slices — verify SUSHI resolves the path correctly. If `series.extension[seriesSequence].value[x]` fails, try `series.extension[seriesSequence].valueCodeableConcept`.

### Phase 5: Narrative Pages, Suppressions, and Build

**Goal**: Generate the full IG HTML site with 0 QA errors.
**Inputs**: Phase 4 complete, IG Publisher JAR in `input-cache/`.
**Operations**:

1. Create `input/pagecontent/index.md` — introduction, scope, authors
2. Create `input/pagecontent/profiles.md` — profile summaries with links
3. Create `input/pagecontent/extensions.md` — extension table with links
4. Create `input/pagecontent/downloads.md` — **use Markdown, not XML**. Content:
   ```markdown
   ### Downloads

   - [Full IG (zip)](full-ig.zip)
   - [NPM Package](package.tgz)
   ```
   > *Changed from iteration 1+2 fixes: use Markdown not XML; only reference files that exist in ci-build output (`full-ig.zip`, `package.tgz`). The `definitions.json.zip`/`definitions.xml.zip` files are only generated by the HL7 publication infrastructure, not in local builds.*
5. Register `downloads.md` in `sushi-config.yaml` pages section:
   ```yaml
   pages:
     index.md:
       title: Home
     profiles.md:
       title: Profiles
     extensions.md:
       title: Extensions
     downloads.md:
       title: Downloads
   ```
6. Create `input/ignoreWarnings.txt` with suppressions:
   ```
   == Suppressed Messages ==
   # AICURA custom code systems are not registered in tx.fhir.org
   %https://aicuramedical.com/fhir/coding%
   # PubChem is not a known FHIR terminology server
   %https://pubchem.ncbi.nlm.nih.gov/compound/%
   # DICOM modality URL is informational
   %https://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_29.html%
   # MedDRA is not registered in tx.fhir.org
   %https://www.meddra.org/%
   # R4B IGs always get version mismatch warnings from R4 dependency packages
   %This IG is version 4.3.0, while the IG%
   ```
   > *Added from iteration 1 fixes: R4B/R4 mismatch and MedDRA suppressions.*
7. Download IG Publisher JAR: `mkdir -p input-cache && curl -L https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o input-cache/publisher.jar`
8. Run full build: `java -jar input-cache/publisher.jar -ig .`

**Validation checkpoint**: Build succeeds (exit 0). QA report: 0 errors, 0 warnings in StructureDefinitions/terminology. Broken links = 0. The QA summary will show **11 non-suppressible errors** — these are all structural/publication checks, not validation errors:
- 5 CodeSystem URL mismatches + 5 paired conformance resource errors: production CodeSystem URLs (`https://aicuramedical.com/fhir/coding/...`) intentionally differ from the IG canonical namespace (`http://aicuramedical.com/fhir/CodeSystem/...`). `ignoreWarnings.txt` matches these (shown as Editor's Comments) but cannot suppress them.
- 1 IG dependency canonical mismatch: `hl7.fhir.uv.extensions.r4` has an internal canonical pointing to `hl7.fhir.uv.extensions` (without `.r4`). Upstream HL7 package issue affecting all R4B IGs.

**Known risks**: The `package-list.json` fetch error from `http://aicuramedical.com/fhir` is expected for unpublished IGs. It appears in the build log but is counted among the 11 structural errors above.

## Key Source Files

| Purpose | Path |
|---------|------|
| ImagingStudy/Series schema | `aicura/os/apollo/schemas/core.graphql:105-169` |
| Observation schema | `aicura/os/apollo/schemas/core.graphql:182-233` |
| Condition schema | `aicura/os/apollo/schemas/core.graphql:392-427` |
| Imaging extensions (URLs) | `aicura/os/apollo/src/extension/fhir_imagingstudy_extension.js` |
| Vector3D types | `aicura/os/apollo/schemas/datatypes.graphql:341-365` |
| MRI sequences | `aicura/data-integration/concepts/codings/imaging/mri_sequences.csv` |
| MRI contrasts | `aicura/data-integration/concepts/codings/imaging/mri_contrasts.csv` |
| PET tracers | `aicura/data-integration/concepts/codings/imaging/pet_tracers.csv` |
| Device manufacturers | `aicura/data-integration/concepts/codings/imaging/device_manufacturer.csv` |
| Acquisition planes | `aicura/data-integration/concepts/codings/imaging/aquisition_plane.csv` |
| Dimensions | `aicura/data-integration/concepts/codings/imaging/dimension.csv` |
| DICOM modalities | `aicura/data-integration/concepts/codings/dicom.modalities.csv` |
| Conditions (SNOMED, MedDRA, LOINC, AICURA) | `aicura/data-integration/concepts/conditions.csv` |
| Observations (LOINC, AICURA, SNOMED) | `aicura/data-integration/concepts/observations.csv` |

## Verification

1. `sushi .` — compiles FSH to JSON without errors or warnings
2. `java -jar input-cache/publisher.jar -ig .` — full IG Publisher build succeeds
3. `output/qa.html` — 0 errors (except package-list.json fetch), 0 warnings
4. Extension URLs match those in production in Apollo (15/15)
5. All profiled code elements have ValueSet bindings

---

## Iteration Log

Iteration results, fixes, and metrics are tracked in separate artifacts per the iterate methodology:

- **`FIXES.md`** — what went wrong and why (the evidence)
- **`METRICS.md`** — cross-iteration comparison (the scorecard)
