Profile: AicuraPatient
Parent: Patient
Id: patient
Title: "AICURA Patient"
Description: "Constrained Patient profile for AICURA's clinical data model, the subject of record for observations, conditions, procedures, imaging studies, and research enrollment."
* insert MetaProfile(patient)
// Must-support elements
* identifier MS
* active MS
* gender MS
* birthDate MS
* deceased[x] MS
// Custom extensions (mirror US Core race/ethnicity without a US Core dependency)
* extension contains
    AicuraRace named race 0..1 MS and
    AicuraEthnicity named ethnicity 0..1 MS
* extension[race].valueCodeableConcept from AicuraRaceEthnicityVS (extensible)
* extension[ethnicity].valueCodeableConcept from AicuraRaceEthnicityVS (extensible)
