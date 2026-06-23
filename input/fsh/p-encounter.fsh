Profile: AicuraEncounter
Parent: Encounter
Id: encounter
Title: "AICURA Encounter"
Description: "Constrained Encounter profile for AICURA's clinical data model, representing study visits and clinical contacts during which observations, conditions, procedures, and imaging studies are recorded."
* insert MetaProfile(encounter)
// Must-support elements
* status MS
* class MS
* type MS
* serviceType MS
* priority MS
* subject MS
* subject only Reference(Patient)
* period MS
* participant MS
* length MS
* reasonCode MS
* diagnosis MS
* location MS
* serviceProvider MS
* partOf MS
// ValueSet bindings
* class from AicuraEncounterClassVS (extensible)
