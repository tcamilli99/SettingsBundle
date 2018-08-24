# SettingsBundle
Demo of creating, reading from, and writing to settings from an app and settings.app.
## Concepts Demonstrated in this app:
### Adding and customizing a Settings.bundle to an iOS app
- Adding Settings.bundle
- Customizing Root.plist
- Adding Group, Text, Toggle Switch, Slider, and Title elements
- Specifying default values for each type of element
- Adding a descriptive footer to a Group element to provide contextual information

### Parsing Root.plist and setting app defaults to the Default value specific in Root.plist.  
This is to address the issue where default values in XCode don't actually get applied when the app is installed.

### Adding an Observer to notify when defaults change
This allows the app to be updated when settings are modified in Settings.app

### Reading from and writing to UserDefaults.standard
### Geting the app version at runtime
