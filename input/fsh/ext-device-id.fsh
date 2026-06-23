Extension: AicuraDeviceId
Id: DeviceId
Title: "Device ID"
Description: "Unique identifier of the imaging device used for this series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/DeviceId"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only string
