Profile: AicuraDevice
Parent: Device
Id: device
Title: "AICURA Device"
Description: "Constrained Device profile for AICURA's clinical data model, representing imaging scanners and other devices referenced by clinical and imaging resources."
* insert MetaProfile(device)
// Must-support elements
* identifier MS
* udiCarrier MS
* status MS
* manufacturer MS
* manufactureDate MS
* expirationDate MS
* lotNumber MS
* serialNumber MS
* deviceName MS
* modelNumber MS
* type MS
* version MS
* patient MS
* patient only Reference(Patient)
* owner MS
* location MS
* note MS
* safety MS
* parent MS
