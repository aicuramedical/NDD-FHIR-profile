Extension: AicuraContrast
Id: Contrast
Title: "MRI Contrast"
Description: "MRI contrast weighting for this imaging series (e.g., T1w, T2w, FLAIR)."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/Contrast"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
