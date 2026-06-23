Extension: AicuraDimension
Id: Dimension
Title: "Dimension"
Description: "Dimensionality of the imaging series (2D or 3D)."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/Dimension"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
