# Harmonization of XRechnung and Peppol BIS Billing 3.0 XRechnung

This document outlines the process of integrating PEPPOL BIS Billing 3.0 rules into XRechnung and, vice versa, of creating the German national ruleset for Peppol BIS Billing from XRechnung national business rules.

The integration is based on XSLT scripts, which are called within the build process.


## File Structure and Location

The relevant files are located here:

```
/
|-- src/
|   |-- xsl/
|       |-- peppol-into-xr.xsl (Transformation script for generation of XRechnung rules)
|       |-- rule-list.xml (Whitelist of Peppol BIS Billing rules to be transferred to XRechnung)
|-- build/
|   |-- bis/ (Peppol BIS Billing rules downloaded here)
|   |-- schematron/
|       |-- cii/ (generated CII rules stored here)
|       |-- ubl/ (generated UBL rules stored here)
|   |-- national-rules/
|       |-- XRechnung-UBL-NRS.sch (National rule set for integration into Peppol BIS Billing)
|-- tools/
    |-- xr-2-peppol-bis-billing-nrs.xsl (transformation file for creation of National Ruleset)
    |-- xr-rules-list.xml (Whitelist of XRechnung business rules to be included in National Ruleset)
    |-- xr-variables-list.xml (Blacklist of XR Schematron variables not used in target rule set)
```


## Transformation of Peppol BIS Billing rules into XRechnung

The corresponding source files are contained within `src/xsl/`.

The transformation is invoked by the Ant target `merge-peppol-rules-with-xr-rules`.

Call

```shell
ant merge-peppol-rules-with-xr-rules
```

### Transformation script `peppol-into-xr.xsl`

This script merges the rules from Peppol Bis Billing 3.0 listed in `rule-list.xml` into the XRechnung rule set by creating multiple phases for CII and UBL and adding the listed rules.

### Set of rules in `rule-list.xml`

This file contains the list of Peppol BIS Billing rules to be included into XRechnung.

### Handling of CII

Notably, as Peppol BIS Billing does not officially support CII, severity levels were set to "warning" per default for all CII rules. **They will be implemented as "error"/"fatal" with an upcoming release.** 

Additionally, some rules had to be customized or added for CII:

- `PEPPOL-EN16931-R008` was added
- `PEPPOL-EN16931-R042` and `PEPPOL-EN16931-R046` were added
- message texts were replaced for `PEPPOL-EN16931-R053`, `PEPPOL-EN16931-R054`, and `PEPPOL-EN16931-R101`
- `PEPPOL-EN16931-R120` was excluded for CII due to syntaxbinding inconsistencies

## Transformation of XRechnung national business rules to Peppol BIS Billing National Ruleset

The corresponding source files are contained within `tools/`.

The transformation is invoked by Ant target `transform-xr-rules-to-peppol-nrs`.

Call

```shell
ant transform-xr-rules-to-peppol-nrs
```

### Transformation script `xr-2-peppol-bis-billing-nrs.xsl`

The script generates the German National Ruleset for PEPPOL BIS Billing to `XRechnung-UBL-NRS.sch` by including the rules listed in `xr-rules-list.xml` and excluding the XRechnung Schematron variables provided in `xr-variables-list.xml`.

### Set of rules in `xr-rules-list.xml`

The file contains a list of XRechnung national business rules to be transformed to the National Ruleset and serves as the basis for the translation of XRechnung rules' IDs and  texts to Peppol BIS Billing rules' IDs and texts. 




