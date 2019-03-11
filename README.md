# Tolle Änderung

# XRechnung Schematron

Technical implementation of the German CIUS (XRechnung) business rules for EN16931:2017 as Schematron Rules for XML validation.

## Releases

You can find packaged [releases on our GitHub project](https://github.com/itplr-kosit/xrechnung-schematron/releases)

## Semantic Versioning

Since December 2018 we introduced [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

Given a version number MAJOR.MINOR.PATCH, we increment the:

1. MAJOR version when we make incompatible changes:
    * That is we introduce changes to the rules which will **DEFINITELY** not validate previously generated XML which was valid to previous major version anymore
1. MINOR version when we add functionality
    * That is we introduce changes to the rules which widen the scope of valid content (e.g. we add new codelist terms or accept new optional XML elements).
    * **CAUTION**: This might break YOUR validation scenario and ability to accept XML content
1. PATCH version when we make backwards-compatible bug fixes.
