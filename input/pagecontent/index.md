### AICURA FHIR Implementation Guide

This Implementation Guide (IG) formally profiles the FHIR R4B resources implemented by **AICURA Medical's** clinical data platform. The guide covers thirteen resource types with associated terminology and extensions.

#### Scope

| Resource | Profile | Description |
|----------|---------|-------------|
| ImagingStudy | [AicuraImagingStudy](StructureDefinition-imaging-study.html) | MRI and PET imaging studies with 15 series-level extensions for acquisition metadata |
| Observation | [AicuraObservation](StructureDefinition-observation.html) | Clinical assessments, laboratory results, genetics, vital signs, and imaging-derived measurements |
| Condition | [AicuraCondition](StructureDefinition-condition.html) | Neurological, cardiovascular, and other clinical conditions |
| Patient | [AicuraPatient](StructureDefinition-patient.html) | Subject of record, with custom race and ethnicity extensions |
| Encounter | [AicuraEncounter](StructureDefinition-encounter.html) | Study visits and clinical contacts |
| Procedure | [AicuraProcedure](StructureDefinition-procedure.html) | Diagnostic and therapeutic procedures |
| Medication | [AicuraMedication](StructureDefinition-medication.html) | Medication definitions referenced by medication statements |
| MedicationStatement | [AicuraMedicationStatement](StructureDefinition-medication-statement.html) | Reported patient medication usage (the medication resource in the FHIR Bundle export) |
| ResearchStudy | [AicuraResearchStudy](StructureDefinition-research-study.html) | Research studies (e.g. ADNI cohorts) patients are enrolled in |
| ResearchSubject | [AicuraResearchSubject](StructureDefinition-research-subject.html) | Patient enrollment in a research study |
| Consent | [AicuraConsent](StructureDefinition-consent.html) | Patient consent for research participation and data use |
| Device | [AicuraDevice](StructureDefinition-device.html) | Imaging scanners and other devices referenced by clinical resources |
| BodyStructure | [AicuraBodyStructure](StructureDefinition-body-structure.html) | Anatomical sites (neuroimaging focus) with a custom laterality extension |

#### Extensions

The ImagingStudy profile includes 15 custom extensions on `ImagingStudy.series` for detailed acquisition metadata such as voxel resolution, MRI sequence type, PET tracer, and device information. Additional custom extensions cover `Race` and `Ethnicity` on Patient, and `Laterality` on BodyStructure. See [Extensions](extensions.html) for the full list.

#### Terminology

Custom CodeSystems and ValueSets define AICURA-specific codes for MRI sequences, contrasts, device manufacturers, PET tracers, observation types, condition codes, encounter classes, body structures, laterality, location qualifiers, and race/ethnicity. External terminologies (SNOMED-CT, LOINC, MedDRA, DICOM, PubChem, HL7 v3 ActCode, and the US CDC Race & Ethnicity code system) are also referenced.

#### Authors

- AICURA Medical GmbH ([https://aicura-medical.com](https://aicura-medical.com))
