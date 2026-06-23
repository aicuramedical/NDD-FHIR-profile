Extension: AicuraVoxelResolution
Id: VoxelResolution
Title: "Voxel Resolution"
Description: "Three-dimensional voxel resolution of an imaging series, with optional unit metadata."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/VoxelResolution"
* insert ExtensionContext(ImagingStudy.series)
* extension contains
    valueX 1..1 and
    valueY 1..1 and
    valueZ 1..1 and
    comparator 0..1 and
    unit 0..1 and
    system 0..1 and
    code 0..1
* extension[valueX].value[x] only decimal
* extension[valueX] ^short = "X dimension voxel size"
* extension[valueY].value[x] only decimal
* extension[valueY] ^short = "Y dimension voxel size"
* extension[valueZ].value[x] only decimal
* extension[valueZ] ^short = "Z dimension voxel size"
* extension[comparator].value[x] only code
* extension[comparator] ^short = "Comparator for quantity"
* extension[unit].value[x] only string
* extension[unit] ^short = "Unit of measure"
* extension[system].value[x] only uri
* extension[system] ^short = "System for unit code"
* extension[code].value[x] only code
* extension[code] ^short = "Coded form of the unit"
