Extension: AicuraTracer
Id: Tracer
Title: "PET Tracer"
Description: "Radiotracer compound used in this PET imaging series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/Tracer"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
