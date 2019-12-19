fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios test
```
fastlane ios test
```
Run tests
### ios beta_minor
```
fastlane ios beta_minor
```
Build new minor version
### ios beta_patch
```
fastlane ios beta_patch
```
Build new patch version
### ios beta
```
fastlane ios beta
```
Creating a new beta version

Steps:

1. Update build and version numbers

2. Push a new beta build to TestFlight

3. Update the repository

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
