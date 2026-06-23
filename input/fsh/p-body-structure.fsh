Profile: AicuraBodyStructure
Parent: BodyStructure
Id: body-structure
Title: "AICURA BodyStructure"
Description: "Constrained BodyStructure profile for AICURA's clinical data model, describing anatomical sites (neuroimaging focus) with a custom laterality extension."
* insert MetaProfile(body-structure)
// Must-support elements
* identifier MS
* active MS
* morphology MS
* location MS
* locationQualifier MS
* description MS
* patient MS
* patient only Reference(Patient)
// Custom extension (BodyStructure has no base laterality element)
* extension contains AicuraLaterality named laterality 0..1 MS
* extension[laterality].valueCodeableConcept from AicuraLateralityVS (extensible)
// ValueSet bindings
* location from AicuraBodyStructureVS (extensible)
* locationQualifier from AicuraLocationQualifierVS (extensible)
