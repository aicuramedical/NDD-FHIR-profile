Extension: AicuraSeriesSequence
Id: SeriesSequence
Title: "Series Sequence"
Description: "MRI sequence type used for this imaging series (e.g., MPRAGE, TSE, FLAIR)."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/SeriesSequence"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only CodeableConcept
