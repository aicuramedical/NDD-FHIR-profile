Profile: AicuraResearchSubject
Parent: ResearchSubject
Id: research-subject
Title: "AICURA ResearchSubject"
Description: "Constrained ResearchSubject profile linking an AICURA patient to a research study, including assigned and actual study arm."
* insert MetaProfile(research-subject)
// Must-support elements
* identifier MS
* status MS
* period MS
* study MS
* individual MS
* individual only Reference(Patient)
* assignedArm MS
* actualArm MS
