Extension: AicuraIsotropicImageResolution
Id: IsotropicImageResolution
Title: "Isotropic Image Resolution"
Description: "Whether the image resolution is isotropic (equal in all dimensions)."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/IsotropicImageResolution"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only boolean
