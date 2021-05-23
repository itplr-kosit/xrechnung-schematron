# Changelog

All notable changes to the Schematron Rules and this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v1.6.0 on 2020-06-30

This version is compatible with XRechnung 2.0.x
### Added
* Schematron Rules
  * BR-DE-23 added
  * BR-DE-24 added
  * BR-DE-25 added

### Changed
  * BR-DE-13 removed

## v1.5.0 on 2020-12-31

This version is compatible with XRechnung 2.0.1

### Added

* Schematron Rules
  * BR-DEX-03 to check existence of BG-DEX-06 in a BG-DEX-01

### Changed

* This version is compatible with XRechnung 2.0.1
* Bump version to 1.5.0 for next release
* Schematron Rules
  * BR-DE-16 is now only relevant, if bt-95, bt-102 or bt-151 exist

### Fixed

* Schematron Rules
  * BR-DEX-02 rewrote rule to not give false negative
  * BR-DE-18 now checks last newline and allows negative Basisbetrag
  * BR-DE-19 flag is set to warning for CII

## v1.4.0 on 2020-07-31

### Added

* Schematron Rules
  * BR-DE-22 to check for unique file names
  * BR-DEX-01 to allow mime type 'application/xml' in XRechnung Extension
  * BR-DEX-02 on checking the sum of prices for UBL sub invoice lines in XRechnung extension

### Changed

* Schematron Rules
  * BR-DE-19 and BR-DE-20 refactoring IBAN rules
  * BR-DE-21 to check specification identifier for extension

### Fixed

* Schematron Rules
  * BR-DE-19 and BR-DE-20 fixed CII IBAN rules

## v1.3.0 on 2019-12-30

### Added

* Schematron Rules
  * BR-DE-19 und BR-DE-20 on IBAN test
  * BR-DE-21 on correct CustomizationID independent of validation scenarios
* Unit tests on Contact rules and on IBAN using xmute instructions  

### Changed

* Removed superflous files 
* Build.xml
  * Version string in Schematron files is configured by build script
  * Overwrite of Schematron compilation files is configurable

## v1.2.1 on 2019-06-24

### Added

- License.md
- Apache 2.0 License to this work
- CEN License statement
- OpenPeppol BIS 3.0 material incl.
  - [specific test instances](test/instances/bis)
  - [BIS Version of Schematron rules](src/bis)

### Changed

- README.md includes List of XRechnung business rules covered by schematron rules


## v1.2.0 on 2018-12-19

This release is compatible to XRechnung 1.2.0.

This version is only by chance the same version as XRechnung!

Because of #19 and #12 it might break your validation and business workflow. Please evaluate impact!

### Added

- Semantic Versioning (see [README](README.md)) #9
- Codelist term 389 (Self-billed invoice) for BT-3 #19

### Changed

- Made descriptions of rules `BR-DE-10` (#18), `BR-DE-11` (#18), `BR-DE-13` (#17), `BR-DE-16` (#16), and `BR-DE-18` (#22)  more precise

### Fixed

- Workaround to inconsistency in CEN Norm and Rules concerning syntax binding as described in [CEN issue #57](https://github.com/CenPC434/validation/issues/57)
- For now we allow for both 'VA' and 'VAT' (see #12)
