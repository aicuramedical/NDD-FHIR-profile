Extension: AicuraAcquisitionPlane
Id: AcquisitionPlane
Title: "Acquisition Plane"
Description: "Anatomical plane of image acquisition (axial, sagittal, coronal)."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/AcquisitionPlane"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
