Extension: AicuraNumberOfFrames
Id: NumberOfFrames
Title: "Number of Frames"
Description: "Number of frames (slices/timepoints) in this imaging series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/NumberOfFrames"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only integer
