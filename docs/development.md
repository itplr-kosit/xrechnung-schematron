## Project Structure

Schematron sources are in `validation/schematron/{cii, ubl-cn, ubl-inv}` directories. 



## Test case development with XML Mutate

We also create test cases using XML Mutate https://projekte.kosit.org/kosit/xml-mutate .

Currently, you need to manually download the newest version from https://projekte.kosit.org/kosit/xml-mutate/-/jobs and put it somewhere local.

If you set the ant property to the URL of directory (full path) like e.g. `xmute.download.url.prefix=file:/mnt/c/data/git-repos/xml-mutator/target` (Linux), you can als execute the `test` target e.g. 

```shell
ant -D xmute.download.url.prefix=file:/home/renzo/projects/xml-mutate/target test
```


Otherwise the build skips this target silently.



The `test/instances` directories contains instances for the sole purpose to cover detailed technical aspects of XRechnung development such as codelist tests among others. These tests have Unit Test character by focusing on testing single Schematron rules in isolation. Hence, these technical cases might not be valid instances w.r.t. to XRechnung specification.


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
