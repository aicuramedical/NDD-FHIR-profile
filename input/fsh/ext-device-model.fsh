Extension: AicuraDeviceModel
Id: device-model
Title: "Device Model"
Description: "Model name of the imaging device used for this series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/device-model"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
