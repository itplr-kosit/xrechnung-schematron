# Harmonization of XRechnung and Peppol BIS Billing 3.0 XRechnung

With the aims of minimizing the delta between XRechnung and Peppol BIS Billing - both CIUSes of the European Norm EN 16931 - a set of Peppol BIS Billing rules is included into XRechnung, and, vice versa, a set of rules to be added to Peppol BIS Billing as the German National ruleset is created from XRechnung national business rules.
This document outlines the process of mutual harmonization of Peppol BIS Billing 3.0 and XRechnung on a technical level.

The integration is based on an automatic XSLT transformation of Schematron rules, which is initiated by an ANT build script. During the build process, transformed/generated files are saved to the `build/`folder. 

## File Structure and Location

The relevant files are located here:

```
/
|-- src/
|   |-- xsl/
|       |-- peppol-into-xr.xsl (Transformation script for generation of XRechnung rules)
|       |-- rule-list.xml (Whitelist of Peppol BIS Billing rules to be transferred to XRechnung)
|-- build/ (temporary files downloaded/created during the build process)
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

Per transformation script `peppol-into-xr.xsl` patterns, global parameters and functions are copied from the Peppol BIS Billing 3.0 Schematron files into the XRechnung Schematron files (UBL and CII, respectively).
The set of rules as provided in `rule-list.xml` are then copied and modified, if necessary (see details below).

The transformation is invoked by the Ant target `merge-peppol-rules-with-xr-rules`.

Call

```shell
ant merge-peppol-rules-with-xr-rules
```

The corresponding source files are contained within `src/xsl/`. The output files are saved in `build/schematron/`.

### Handling of CII

Notably, as Peppol BIS Billing does not officially support CII, severity levels were set to "warning" per default for all CII rules. **They will be implemented as "error"/"fatal" with an upcoming release.** 

### Modifications

Additionally, some rules had to be added or customized:

- `PEPPOL-EN16931-R008` was added for CII
- `PEPPOL-EN16931-R042` and `PEPPOL-EN16931-R046` were added for CII
- `PEPPOL-EN16931-R053` and `PEPPOL-EN16931-R055` were modified for CII due to bugs in source code
- message texts were replaced in `PEPPOL-EN16931-R053`, `PEPPOL-EN16931-R054`, and `PEPPOL-EN16931-R101` for CII
- `PEPPOL-EN16931-R120` was excluded for CII due to syntaxbinding inconsistencies
- the slack function provided in Peppol BIS Billing and rules `PEPPOL-EN16931-R040` and `PEPPOL-EN16931-R120` were modified for UBL and CII to handle rounding without decimals places in currency HUF

## Transformation of XRechnung national business rules to Peppol BIS Billing National Ruleset

XRechnung Schematron rules as whitelisted in `xr-rules-list.xml` are transformed via `xr-2-peppol-bis-billing-nrs.xsl` to create the German National Ruleset for Peppol BIS Billing. XRechnung Schematron variables not blacklisted in `xr-variables-list.xml` are included as global variables. To ensure that the German national rules apply only in case of German seller AND customer country (BT-40 and BT-55), respective predicates are applied to the rules' contexts. 
The list of rules in `xr-rules-list.xml` provides translations of XRechnung rules' IDs and texts to Peppol BIS Billing rules' IDs and texts that are applied during the transformation.

As Peppol BIS Billing does not officially support CII, only UBL is taken into account in the transformation process.

The transformation is invoked by Ant target `transform-xr-rules-to-peppol-nrs`.

Call

```shell
ant transform-xr-rules-to-peppol-nrs
```

The corresponding source files are contained within `tools/`. The output file is saved in `build/national-rules/`.