Profile: AicuraImagingStudy
Parent: ImagingStudy
Id: imaging-study
Title: "AICURA ImagingStudy"
Description: "Constrained ImagingStudy profile for AICURA's medical imaging data model with series-level extensions for MRI/PET metadata."
* insert MetaProfile(imaging-study)
// Must-support top-level elements
* status MS
* subject MS
* subject only Reference(Patient)
* started MS
* description MS
* series MS
// Series backbone must-support
* series.uid MS
* series.modality MS
* series.description MS
* series.numberOfInstances MS
* series.bodySite MS
* series.laterality MS
// Series extensions (all 0..1)
* series.extension contains
    AicuraVoxelResolution named voxelResolution 0..1 MS and
    AicuraImageResolution named imageResolution 0..1 MS and
    AicuraIsotropicVoxelResolution named isotropicVoxelResolution 0..1 and
    AicuraIsotropicImageResolution named isotropicImageResolution 0..1 and
    AicuraMagneticFieldStrength named magneticFieldStrength 0..1 MS and
    AicuraEchotime named echotime 0..1 and
    AicuraNumberOfFrames named numberOfFrames 0..1 and
    AicuraDeviceManufacturer named deviceManufacturer 0..1 and
    AicuraDeviceModel named deviceModel 0..1 and
    AicuraDeviceId named deviceId 0..1 and
    AicuraSeriesSequence named seriesSequence 0..1 MS and
    AicuraTracer named tracer 0..1 and
    AicuraContrast named contrast 0..1 MS and
    AicuraAcquisitionPlane named acquisitionPlane 0..1 MS and
    AicuraDimension named dimension 0..1 MS
// ValueSet bindings on CodeableConcept extensions
* series.extension[seriesSequence].valueCodeableConcept from AicuraMRISequenceVS (extensible)
* series.extension[contrast].valueCodeableConcept from AicuraMRIContrastVS (extensible)
* series.extension[deviceManufacturer].valueCodeableConcept from AicuraDeviceManufacturerVS (extensible)
* series.extension[tracer].valueCodeableConcept from AicuraPETTracerVS (extensible)
* series.extension[acquisitionPlane].valueCodeableConcept from AicuraAcquisitionPlaneVS (extensible)
* series.extension[dimension].valueCodeableConcept from AicuraDimensionVS (extensible)
