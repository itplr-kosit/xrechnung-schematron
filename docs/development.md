## Project Structure

Schematron sources are in `validation/schematron/{cii, ubl-cn, ubl-inv}` directories. 


## Test case development with XML Mutate

We also create test cases using XML Mutate https://projekte.kosit.org/kosit/xml-mutate .

Currently, you need to manually download the newest version from https://projekte.kosit.org/kosit/xml-mutate/-/jobs and put it somewhere local.

If you set the ant property to the URL of directory (full path) like e.g. `xmute.download.url.prefix=file:/mnt/c/data/git-repos/xml-mutator/target` (Linux), you can als execute the `test` target e.g. 

```shell
ant -Dxmute.download.url.prefix=file:/home/renzo/projects/xml-mutate/target test
```

For Windows users:

```shell
ant "-Dxmute.download.url.prefix=file:/c:/dev/git/xml-mutate/target" test
```


Otherwise the build skips this target silently.



The `test/instances` directories contains instances for the sole purpose to cover detailed technical aspects of XRechnung development such as codelist tests among others. These tests have Unit Test character by focusing on testing single Schematron rules in isolation. Hence, these technical cases might not be valid instances w.r.t. to XRechnung specification. 
There are three directoriesfor the different formats (cii, ubl-cn, ubl-inv). The naming convention for the tests is *format*-*rule*-*description*.xml (e.g. cii-br-de-24-test-bg-17.xml).


### Conventions

In order to keep test case development consistent it is important to follow several conventions.

#### Common names for different Schematron rule sets

The following names are used to reference different schematron files

```
ceninv:  for CEN UBL Invoice (and Credit Note) rules
cencii:  for CEN UN/CEFACT CII rules
xrinv:   for XRechnung UBL Invoice
xrcn:    for XRechnung UBL Credit Note
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
This requires to set some at command line:

```
ant -Dxmute.download.url.prefix='file:/home/renzo/projects/xml-mutate/target' clean dist
```

* Tag the last commit according to the following naming rule: `release-${xr-schematron.version.full}` e.g.
  `git tag release-1.6.0 && git push origin release-1.6.0` 

### Publish

* Draft a new release at https://github.com/itplr-kosit/xrechnung-schematron/releases/new
  * Choose the git tag you just created
* Add release title of the following scheme: `XRechnung Schematron ${xr-schematron.version.full} compatible with XRechnung ${xrechnung.version} in version ${testsuire.release.version}`
* Copy & paste the high quality changelog entries for this release from CHANGELOG.md
* Upload distribution zip and tick mark this release as a `pre-release`.
* If **all** released componentes are checked to be okay, then uncheck pre-release

### Post-Release

* Change the version of XRechnung Schematron in `build.xml` to the next release and commit

You are done :smile:
