Profile: AicuraConsent
Parent: Consent
Id: consent
Title: "AICURA Consent"
Description: "Constrained Consent profile for AICURA's clinical data model, capturing a patient's consent for research participation and data use."
* insert MetaProfile(consent)
// Must-support elements
* status MS
* scope MS
* category MS
* patient MS
* patient only Reference(Patient)
* dateTime MS
* performer MS
* organization MS
* source[x] MS
* policy MS
* policyRule MS
* verification MS
* provision MS
