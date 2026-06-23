Extension: AicuraDeviceManufacturer
Id: DeviceManufacturer
Title: "Device Manufacturer"
Description: "Manufacturer of the imaging device used for this series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/DeviceManufacturer"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
