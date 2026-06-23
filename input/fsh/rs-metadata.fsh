RuleSet: MetaProfile(profile)
* ^url = "http://aicura-medical.com/fhir/StructureDefinition/{profile}"

RuleSet: ExtensionContext(path)
* ^context[+].type = #element
* ^context[=].expression = "{path}"
