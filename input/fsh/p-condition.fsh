Profile: AicuraCondition
Parent: Condition
Id: condition
Title: "AICURA Condition"
Description: "Constrained Condition profile for AICURA's clinical data model, covering neurological, cardiovascular, and other disorders."
* insert MetaProfile(condition)
// Must-support elements
* clinicalStatus MS
* verificationStatus MS
* category MS
* severity MS
* code MS
* bodySite MS
* subject MS
* subject only Reference(Patient)
* encounter MS
* onset[x] MS
* abatement[x] MS
* recordedDate MS
* stage MS
* evidence MS
// ValueSet bindings
* code from AicuraConditionCodeVS (extensible)
