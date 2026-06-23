### Extensions

#### ImagingStudy series extensions

The following extensions are defined on `ImagingStudy.series` and capture imaging acquisition metadata.

| Extension | Type | Description |
|-----------|------|-------------|
| [VoxelResolution](StructureDefinition-VoxelResolution.html) | Complex (X/Y/Z decimal + unit) | Three-dimensional voxel resolution |
| [ImageResolution](StructureDefinition-ImageResolution.html) | Complex (X/Y/Z integer) | Three-dimensional image resolution |
| [IsotropicVoxelResolution](StructureDefinition-IsotropicVoxelResolution.html) | Boolean | Whether voxel resolution is isotropic |
| [IsotropicImageResolution](StructureDefinition-IsotropicImageResolution.html) | Boolean | Whether image resolution is isotropic |
| [MagneticFieldStrength](StructureDefinition-MagneticFieldStrength.html) | Decimal | MRI scanner field strength in Tesla |
| [Echotime](StructureDefinition-Echotime.html) | Decimal | Echo time (TE) in milliseconds |
| [NumberOfFrames](StructureDefinition-NumberOfFrames.html) | Integer | Number of frames/slices |
| [DeviceManufacturer](StructureDefinition-DeviceManufacturer.html) | CodeableConcept | Imaging device manufacturer |
| [device-model](StructureDefinition-device-model.html) | CodeableConcept | Imaging device model |
| [DeviceId](StructureDefinition-DeviceId.html) | String | Imaging device identifier |
| [SeriesSequence](StructureDefinition-SeriesSequence.html) | CodeableConcept | MRI pulse sequence type |
| [Tracer](StructureDefinition-Tracer.html) | CodeableConcept | PET radiotracer compound |
| [Contrast](StructureDefinition-Contrast.html) | CodeableConcept | MRI contrast weighting |
| [AcquisitionPlane](StructureDefinition-AcquisitionPlane.html) | CodeableConcept | Anatomical acquisition plane |
| [Dimension](StructureDefinition-Dimension.html) | CodeableConcept | 2D or 3D dimensionality |

#### Cross-resource extensions

These extensions are defined on the clinical and demographic profiles added alongside ImagingStudy.

| Extension | Context | Type | Description |
|-----------|---------|------|-------------|
| [Race](StructureDefinition-Race.html) | Patient | CodeableConcept | Patient race (US CDC Race & Ethnicity code system) |
| [Ethnicity](StructureDefinition-Ethnicity.html) | Patient | CodeableConcept | Patient ethnicity (US CDC Race & Ethnicity code system) |
| [Laterality](StructureDefinition-Laterality.html) | BodyStructure | CodeableConcept | Body side laterality (left, right, bilateral) |
