Profile: AicuraObservation
Parent: Observation
Id: observation
Title: "AICURA Observation"
Description: "Constrained Observation profile for AICURA's clinical assessments, laboratory results, genetics, vital signs, and imaging-derived measurements."
* insert MetaProfile(observation)
// Must-support elements
* status MS
* category MS
* code MS
* subject MS
* subject only Reference(Patient)
* encounter MS
* effective[x] MS
* value[x] MS
* performer MS
* derivedFrom MS
* component MS
* bodySite MS
* interpretation MS
* method MS
// ValueSet bindings
* code from AicuraObservationCodeVS (extensible)
