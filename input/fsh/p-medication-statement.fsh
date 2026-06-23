Profile: AicuraMedicationStatement
Parent: MedicationStatement
Id: medication-statement
Title: "AICURA MedicationStatement"
Description: "Constrained MedicationStatement profile for AICURA's clinical data model, recording a patient's reported medication usage. This is the medication resource included in AICURA's FHIR Bundle export."
* insert MetaProfile(medication-statement)
// Must-support elements
* status MS
* statusReason MS
* category MS
* medication[x] MS
* subject MS
* subject only Reference(Patient)
* context MS
* effective[x] MS
* dateAsserted MS
* informationSource MS
* reasonCode MS
* reasonReference MS
* dosage MS
