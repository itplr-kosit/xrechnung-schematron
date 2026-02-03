# Project Structure

Schematron sources are in `validation/schematron/{cii, ubl}` directories.

## Testing

We are only testing with **Saxon HE 12.8** and later.
Proper execution of the rules with other XSLT environments cannot be guaranteed.

Hint: the CEN rules are also tested with Saxon HE.

## Test case development with XML Mutate

We also create test cases using XML Mutate https://projekte.kosit.org/kosit/xml-mutate.

The `test/instances` directories contains instances for the sole purpose to cover detailed technical aspects of XRechnung development such as codelist tests among others. These tests have Unit Test character by focusing on testing single Schematron rules in isolation. Hence, these technical cases might not be valid instances w.r.t. to XRechnung specification. 
There are three directories for the different formats (cii, ubl-cn, ubl-inv). The naming convention for the tests is *format*-*rule*-*description*.xml (e.g. cii-br-de-24-test-bg-17.xml).

### Test requirements

#### Avoid "A sequence is not allowed.." errors

This error occurs if an assertion uses an XPath function which only expects one element per function call (e.g. matches()), but receives several.

If a rule tests a specific element which can occur multiple times, a test instance has to have multiple occurences of the element.

If a rule tests a specific element within a parent element, which can occur multiple times, a test instance has to have multiple occurences of the parent element.

### Conventions

In order to keep test case development consistent it is important to follow several conventions.

#### Common names for different Schematron rule sets

The following names are used to reference different schematron files

```
cenubl:  for CEN UBL Invoice (and Credit Note) rules
cencii:  for CEN UN/CEFACT CII rules
xrubl:   for XRechnung UBL Invoice (and Credit Note)
xrcii:   for XRechnung UN/CEFACT CII
```

## The build environment

We recommend `Apache Ant` version 1.10.x or newer (but should work with > 1.8.x).

The main `ant` targets for developing are:

* `compile`
* `test` (unit testing)
* and `dist` (creating the distribution artefact)

However, because of the complex dependencies, you may only expect `compile` target to work without any customizations.

## Distribution

The `ant` target `dist` creates the distribution zip archive.

## Release

### Checklist

* Are all issues scheduled for the release solved?
* Is everything merged to master branch?
* Do Schematron files include correct version of XRechnung Specification? 
* Make sure that CHANGELOG.md is up to date


### Prepare

* Make sure you committed and pushed everything 
* Create the distribution by **not** using your development properties file.

### Deploy

* Tag the last commit according to the following naming rule: `${xr-schematron.version.full}-{rc}` e.g.
  `git tag 2.5.0-rc1 && git push origin v2.5.0-rc1`

### Publish

* If **all** released components are checked to be okay, tag the last commit according to the following naming rule: `v${xr-schematron.version.full}` e.g.
  `git tag v2.5.0 && git push origin v2.5.0`
* The tag will trigger a release pipeline and create a GitLab release
* Copy & paste the high quality changelog entries for this release from CHANGELOG.md.
* The release title should follow this scheme: `XRechnung Schematron ${xr-schematron.version.full} compatible with XRechnung ${xrechnung.version}`

* Publish the new release in GitHub

### Post-Release

* Change the version of XRechnung Schematron in `build.xml` to the next release and commit

You are done :smile:
