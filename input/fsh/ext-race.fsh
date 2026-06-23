Extension: AicuraRace
Id: Race
Title: "Race"
Description: "Patient race, coded with the US CDC Race & Ethnicity code system. Mirrors the US Core race extension without taking a US Core dependency."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/Race"
* insert ExtensionContext(Patient)
* value[x] only CodeableConcept
