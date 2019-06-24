# Changelog

All notable changes to the Schematron Rules and this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## v1.2.1 on 2018-06-24

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
