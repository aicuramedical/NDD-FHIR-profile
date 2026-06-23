Extension: AicuraEthnicity
Id: Ethnicity
Title: "Ethnicity"
Description: "Patient ethnicity, coded with the US CDC Race & Ethnicity code system. Mirrors the US Core ethnicity extension without taking a US Core dependency."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/Ethnicity"
* insert ExtensionContext(Patient)
* value[x] only CodeableConcept
