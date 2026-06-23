Extension: AicuraImageResolution
Id: ImageResolution
Title: "Image Resolution"
Description: "Three-dimensional image resolution (pixel/voxel counts) of an imaging series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/ImageResolution"
* insert ExtensionContext(ImagingStudy.series)
* extension contains
    valueX 1..1 and
    valueY 1..1 and
    valueZ 1..1
* extension[valueX].value[x] only integer
* extension[valueX] ^short = "X dimension pixel count"
* extension[valueY].value[x] only integer
* extension[valueY] ^short = "Y dimension pixel count"
* extension[valueZ].value[x] only integer
* extension[valueZ] ^short = "Z dimension pixel count"
