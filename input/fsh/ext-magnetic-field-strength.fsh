Extension: AicuraMagneticFieldStrength
Id: MagneticFieldStrength
Title: "Magnetic Field Strength"
Description: "Magnetic field strength (in Tesla) of the MRI scanner used for this series."
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/MagneticFieldStrength"
* insert ExtensionContext(ImagingStudy.series)
* value[x] only decimal
