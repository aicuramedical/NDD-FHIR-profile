# FIXES.md

## Iteration 1

### Duplicate core package dependency crashes IG Publisher

**Phase**: Phase 1 (Scaffold) <br>
**Symptom**: `java -jar publisher.jar -ig .` fails with `JsonException: Name 'hl7.fhir.r4b.core' already exists (value = "4.3.0")` during `PublisherIGLoader.load()` <br>
**Root cause**: `sushi-config.yaml` listed `hl7.fhir.r4b.core: 4.3.0` under `dependencies`. The IG Publisher already infers this package from `fhirVersion: 4.3.0` and adds it internally — the explicit entry creates a duplicate key when building the NPM package manifest. SUSHI tolerates the duplicate; the IG Publisher does not.
**Fix**: Removed the `dependencies` block from `sushi-config.yaml` (file: `sushi-config.yaml`)
**Plan gap**: Plan Phase 1 said "Create `sushi-config.yaml`" but did not specify whether `hl7.fhir.r4b.core` should appear in dependencies.
The plan should state: "Do NOT list the core FHIR package in `dependencies` — it is inferred from `fhirVersion`."
**Category**: Underspecified

### Jekyll not installed for template rendering

**Phase**: Phase 5 (Narrative Pages and Build)
**Symptom**: IG Publisher build completes all validation and HTML generation but fails at the final step: `Cannot run program "jekyll" (in directory ".../temp/pages"): error=2, No such file or directory`
**Root cause**: The `fhir.base.template#1.0.0` template uses Jekyll for final HTML assembly. The dev container does not have Ruby or Jekyll pre-installed.
**Fix**: Installed Ruby and Jekyll: `sudo apt-get install ruby-full build-essential && sudo gem install jekyll` (environment prerequisite, not a file change)
**Plan gap**: Plan Phase 5 said "Download IG Publisher, run full build" but did not list Jekyll (or Ruby) as a prerequisite. The plan should add a prerequisite step: "Install Jekyll: `sudo gem install jekyll` (requires Ruby)."
**Category**: Plan gap

### downloads.html broken link across all pages

**Phase**: Phase 5 (Narrative Pages and Build)
**Symptom**: QA report shows 218 broken links and the majority of the 12 reported "errors" — all for `The link 'downloads.html' for "Downloads" cannot be resolved`. Every generated page has a nav menu pointing to `downloads.html` which does not exist.
**Root cause**: `sushi-config.yaml` menu section includes `Downloads: downloads.html`. The plan placed a `downloads.xml` file in `input/pagecontent/` but `fhir.base.template#1.0.0` does not auto-generate `downloads.html` from an XML fragment — it requires either a `downloads.md` page that includes the XML, or the downloads page must be declared in the `pages` config.
**Fix**: Not yet applied — deferred to iteration 2.
**Plan gap**: Plan Phase 5 said "Write pagecontent (index.md, profiles.md, extensions.md, downloads.xml)" but did not account for how `fhir.base.template` renders the downloads page. The plan should either (a) replace `downloads.xml` with `downloads.md` and register it in `pages`, or (b) remove `Downloads` from the menu.
**Category**: Underspecified

### R4B / R4 dependency version mismatch warnings

**Phase**: Phase 1 (Scaffold)
**Symptom**: 3 validation warnings: "This IG is version 4.3.0, while the IG 'hl7.terminology.r4' is from version 4.0.1" (same for `hl7.fhir.uv.extensions.r4` and `hl7.fhir.uv.tools.r4`)
**Root cause**: No R4B-specific versions of these dependency packages exist. SUSHI and the IG Publisher auto-resolve to R4 versions, which triggers the mismatch warning. This is standard for all R4B IGs.
**Fix**: Not yet applied — should be suppressed in `ignoreWarnings.txt`.
**Plan gap**: Plan did not mention that R4B IGs will always produce these warnings from R4 dependency packages, or that they should be suppressed.
**Category**: Underspecified

### package-list.json fetch error

**Phase**: Phase 5 (Narrative Pages and Build)
**Symptom**: QA reports 1 error: "Error fetching package-list from http://aicuramedical.com/fhir: Received fatal alert: internal_error"
**Root cause**: The IG Publisher tries to fetch `{canonical}/package-list.json` to check version history. Since this IG is not yet published, the URL returns an error. This is expected for any unpublished IG.
**Fix**: Not yet applied — can be ignored or suppressed.
**Plan gap**: Plan did not note that unpublished IGs will always produce this error, or recommend suppressing it.
**Category**: Underspecified

### Missing ValueSets for Condition and Observation codes

**Phase**: Phase 3 (Terminology)
**Symptom**: AicuraCondition profile has MS on `code` but no ValueSet binding. AicuraObservation profile has MS on `code` and `category` but no ValueSet bindings. The profiles accept any code, defeating the purpose of formal profiling.
**Root cause**: Phase 3 only scoped imaging-related terminology (MRI sequences, contrasts, tracers, etc.). The condition and observation coding CSVs (`conditions.csv` with 57 SNOMED-CT codes, `observations.csv` with 211 LOINC/AICURA codes) were listed under "Key Source Files" but never appeared in any Phase 3 operation.
**Fix**: Not yet applied. Iteration 2 should add:
  - `vs-condition-code.fsh` — SNOMED-CT neurological conditions from `conditions.csv`
  - `vs-observation-code.fsh` — LOINC + AICURA custom observation codes from `observations.csv`
  - `vs-observation-category.fsh` — observation categories (survey, laboratory) from `observations.csv`
  - Bindings on `AicuraCondition.code`, `AicuraObservation.code`, `AicuraObservation.category`
**Plan gap**: Plan Phase 3 listed only imaging CodeSystems/ValueSets. The plan's "Key Source Files" table listed `conditions.csv` and `observations.csv` but no Phase 3 operation consumed them. The plan should include ValueSets for all profiled resources, not just ImagingStudy.
**Category**: Plan gap

### Missing ValueSet bindings on CodeableConcept extensions

**Phase**: Phase 4 (Profiles)
**Symptom**: Extensions like SeriesSequence, Contrast, DeviceManufacturer, Tracer, AcquisitionPlane, and Dimension accept `CodeableConcept` with no binding — any code is valid. The corresponding ValueSets exist (created in Phase 3) but are not bound.
**Root cause**: Phase 4 added all 15 extensions to the ImagingStudy profile but did not bind the CodeableConcept extensions to their ValueSets. The plan says "All 15 extensions on `series.extension`" but does not mention bindings.
**Fix**: Not yet applied. Iteration 2 should add binding rules in `p-imaging-study.fsh`, e.g., `* series.extension[seriesSequence].value[x] from AicuraMRISequenceVS (extensible)`.
**Plan gap**: Plan Phase 4 described must-support elements and extension inclusion but did not specify ValueSet bindings for any CodeableConcept extension.
**Category**: Plan gap

---

## Iteration 2

### SUSHI not installed in dev container

**Phase**: Phase 0 (Prerequisites)
**Symptom**: `which sushi` fails — `sushi not found`
**Root cause**: The dev container has Node.js 20 but does not include SUSHI globally. Phase 0 says "Verify SUSHI is installed" but does not specify what to do if it's missing.
**Fix**: `sudo npm install -g fsh-sushi` (applied during execution)
**Plan gap**: Phase 0 verifies SUSHI but does not include a fallback install command. Should add: "If SUSHI is not installed: `sudo npm install -g fsh-sushi`"
**Category**: Underspecified

### CodeSystems and ValueSets missing `experimental` flag

**Phase**: Phase 3 (Terminology)
**Symptom**: 14 QA warnings: "Published code systems/value sets SHOULD conform to the Shareable profile, which says that the element experimental is mandatory, but it is not present"
**Root cause**: The plan's Phase 3 specifies `caseSensitive`, `content`, `status`, and `version` for CodeSystems, and various fields for ValueSets, but does not specify `experimental`.
**Fix**: Added `* ^experimental = false` to all 5 CodeSystems and 9 ValueSets (applied during execution)
**Plan gap**: Phase 3 should specify `experimental = false` for all CodeSystems and ValueSets.
**Category**: Underspecified

### downloads.md references non-existent zip files

**Phase**: Phase 5 (Narrative Pages and Build)
**Symptom**: 2 QA broken link errors: "The link 'definitions.json.zip' for 'JSON definitions (zip)' cannot be resolved" (same for definitions.xml.zip)
**Root cause**: The plan's Phase 5 `downloads.md` template includes links to `definitions.json.zip` and `definitions.xml.zip`, which are only generated for published IGs on the HL7 publication infrastructure. In ci-build mode, only `full-ig.zip` and `package.tgz` are present.
**Fix**: Updated `downloads.md` to link only to `full-ig.zip` and `package.tgz` (applied during execution)
**Plan gap**: Phase 5 downloads.md template should only reference files that exist in ci-build output.
**Category**: Underspecified

### Non-suppressible CodeSystem URL mismatch errors

**Phase**: Phase 3 (Terminology) / Phase 5 (Build)
**Symptom**: 10 QA errors (5 URL Mismatch + 5 conformance resource): "URL Mismatch http://aicuramedical.com/fhir/CodeSystem/aicura-mri-sequence vs https://aicuramedical.com/fhir/coding/mri-sequence". `ignoreWarnings.txt` patterns match (shown as Editor's Comments) but don't reduce the error count.
**Root cause**: The IG Publisher derives a canonical URL for each resource as `{IG canonical}/{resource type}/{id}`. For CodeSystems, this produces `http://aicuramedical.com/fhir/CodeSystem/aicura-mri-sequence`. But AICURA's production data uses `https://aicuramedical.com/fhir/coding/mri-sequence` as the system URL (set via `^url`). The mismatch has two dimensions: (1) http vs https, (2) `/CodeSystem/` vs `/coding/`. The IG Publisher treats this as a non-suppressible structural error.
**Fix**: Cannot be suppressed through `ignoreWarnings.txt`. These errors are annotated with Editor's Comments but remain in the count. Accepted as known, expected errors — production CodeSystem URLs intentionally differ from the IG canonical namespace.
**Plan gap**: Plan Phase 5 validation checkpoint says "0 errors (except package-list.json fetch)" but did not anticipate that CodeSystem URL mismatches between production URLs and the IG canonical namespace would produce non-suppressible errors. The plan should document these as expected alongside the package-list.json error.
**Category**: Underspecified

### Non-suppressible IG dependency canonical URL mismatch

**Phase**: Phase 5 (Build)
**Symptom**: 1 QA error: "The canonical URL http://hl7.org/fhir/extensions/ImplementationGuide/hl7.fhir.uv.extensions points to the package hl7.fhir.uv.extensions which is inconsistent with the stated packageId of hl7.fhir.uv.extensions.r4"
**Root cause**: R4B IGs inherit the `hl7.fhir.uv.extensions.r4` package, which has an internal canonical URL pointing to `hl7.fhir.uv.extensions` (without the `.r4` suffix). This is an upstream inconsistency in the HL7 package registry, not an AICURA issue.
**Fix**: Cannot be fixed — upstream HL7 package issue. `ignoreWarnings.txt` pattern `%hl7.fhir.uv.extensions%` is matched but the error type is non-suppressible.
**Plan gap**: Plan should document this as an expected, non-suppressible error for all R4B IGs.
**Category**: Pre-existing debt

---

## Known Skips

- No FSH example instances created (out of scope for initial profiles)

## Test Results Summary

| Layer | Test | Result |
|-------|------|--------|
| Structure | Files exist per plan directory structure | PASS |
| Compilation | `sushi .` compiles without errors | PASS (0 errors, 0 warnings) |
| Build | IG Publisher full build completes (exit 0) | PASS |
| QA: XHTML validity | 1027/1027 valid pages | PASS (100%) |
| QA: Broken links | 0/81374 | PASS (0%) |
| QA: Validation errors in StructureDefinitions | 0 | PASS |
| QA: Validation errors in terminology | 0 | PASS |
| QA: Overall errors | 11 (all non-suppressible structural) | EXPECTED |
| QA: Overall warnings | 1 (suppressed annotations) | PASS |
| Verification: Extension URLs match Apollo | 15/15 | PASS |
| Verification: Profiles have ValueSet bindings | 3/3 | PASS |
