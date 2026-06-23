### Profiles

This IG defines thirteen FHIR R4B profiles:

#### AicuraImagingStudy

[AicuraImagingStudy](StructureDefinition-imaging-study.html) constrains ImagingStudy with must-support on core elements (status, subject, started, description, series) and adds 15 series-level extensions for imaging acquisition metadata including voxel resolution, image resolution, MRI sequence, contrast weighting, PET tracer, and device information.

#### AicuraObservation

[AicuraObservation](StructureDefinition-observation.html) constrains Observation with must-support on status, category, code, subject, effective, value, performer, derivedFrom, component, bodySite, interpretation, and method. The `code` element is bound to the [AicuraObservationCodeVS](ValueSet-aicura-observation-code.html) covering LOINC, SNOMED-CT, and AICURA custom observation codes.

#### AicuraCondition

[AicuraCondition](StructureDefinition-condition.html) constrains Condition with must-support on clinicalStatus, verificationStatus, category, severity, code, bodySite, subject, encounter, onset, abatement, recordedDate, stage, and evidence. The `code` element is bound to the [AicuraConditionCodeVS](ValueSet-aicura-condition-code.html) spanning SNOMED-CT, AICURA custom, MedDRA, and LOINC codes.

#### AicuraPatient

[AicuraPatient](StructureDefinition-patient.html) constrains Patient with must-support on identifier, active, gender, birthDate, and deceased. It adds `race` and `ethnicity` extensions bound to the [AicuraRaceEthnicityVS](ValueSet-aicura-race-ethnicity.html) (US CDC Race & Ethnicity code system); these mirror the US Core race/ethnicity extensions without taking a US Core dependency.

#### AicuraEncounter

[AicuraEncounter](StructureDefinition-encounter.html) constrains Encounter with must-support on status, class, type, serviceType, priority, subject, period, participant, length, reasonCode, diagnosis, location, serviceProvider, and partOf. The `class` element is bound to the [AicuraEncounterClassVS](ValueSet-aicura-encounter-class.html) (HL7 v3 ActCode).

#### AicuraProcedure

[AicuraProcedure](StructureDefinition-procedure.html) constrains Procedure with must-support on status, category, code, subject, encounter, performed, performer, location, reasonCode, reasonReference, bodySite, outcome, complication, followUp, focalDevice, usedReference, and usedCode. The `bodySite` element is bound to the [AicuraBodyStructureVS](ValueSet-aicura-body-structure.html).

#### AicuraMedication

[AicuraMedication](StructureDefinition-medication.html) constrains Medication with must-support on code, status, manufacturer, form, amount, ingredient, and batch. It defines the medications referenced by medication statements.

#### AicuraMedicationStatement

[AicuraMedicationStatement](StructureDefinition-medication-statement.html) constrains MedicationStatement with must-support on status, statusReason, category, medication, subject, context, effective, dateAsserted, informationSource, reasonCode, reasonReference, and dosage. This is the medication resource included in AICURA's FHIR Bundle export.

#### AicuraResearchStudy

[AicuraResearchStudy](StructureDefinition-research-study.html) constrains ResearchStudy with must-support on identifier, title, status, primaryPurposeType, phase, category, focus, condition, period, description, sponsor, principalInvestigator, site, arm, and objective. It describes the studies (e.g. ADNI cohorts) that patients are enrolled in.

#### AicuraResearchSubject

[AicuraResearchSubject](StructureDefinition-research-subject.html) constrains ResearchSubject with must-support on identifier, status, period, study, individual, assignedArm, and actualArm.

#### AicuraConsent

[AicuraConsent](StructureDefinition-consent.html) constrains Consent with must-support on status, scope, category, patient, dateTime, performer, organization, source, policy, policyRule, verification, and provision. It captures a patient's consent for research participation and data use.

#### AicuraDevice

[AicuraDevice](StructureDefinition-device.html) constrains Device with must-support on identifier, udiCarrier, status, manufacturer, manufactureDate, expirationDate, lotNumber, serialNumber, deviceName, modelNumber, type, version, patient, owner, location, note, safety, and parent. It represents imaging scanners and other devices referenced by clinical and imaging resources.

#### AicuraBodyStructure

[AicuraBodyStructure](StructureDefinition-body-structure.html) constrains BodyStructure with must-support on identifier, active, morphology, location, locationQualifier, description, and patient. The `location` and `locationQualifier` elements are bound to the [AicuraBodyStructureVS](ValueSet-aicura-body-structure.html) and [AicuraLocationQualifierVS](ValueSet-aicura-location-qualifier.html) respectively, and a custom `laterality` extension (bound to [AicuraLateralityVS](ValueSet-aicura-laterality.html)) captures body side, which base BodyStructure does not model.
