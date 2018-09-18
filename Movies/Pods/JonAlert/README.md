JonAlert
===========
[![CocoaPods Compatible](https://img.shields.io/badge/pod-1.0.0-red.svg)](https://cocoapods.org/pods/JonAlert)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://github.com/jonSurrey/JonAlert/blob/master/LICENSE)

A simple and elegant alert like Spotify's one, written in Swift. JonAlert can be used to give feedbacks to the user after he/she performed some action.

![Gif](https://media.giphy.com/media/c6OiUftAyORAsOflw6/giphy.gif)

### How to use

```swift
// First import the library to the ViewController you want to use it.
import JonAlert

// Then, you just have to call the alert anywhere you desire:
JonAlert.show(message: "Simple message...")
```

### Success and Error Alerts

```swift
// If you want to show feedback for a success or error situation, 
// you can simply call:
JonAlert.showSuccess(message: "Success!!")
JonAlert.showError(message: "Something went wrong...")
```

### Display a custom icon

```swift
// Last but not least, you can use a custom image to be displayed:
let myImage = UIImage(named: "myImage")
JonAlert.show(message: "Simple message...", andIcon: myImage)
```

### Changing the alert displaying speed

```swift
// The alert default displaying speed is 1 second. So, when you
// call any of the "show" methods the time between the alert 
// appearing and disappearing will be of 1 second. 

// To change de default time (in seconds) of the alert, use: 
JonAlert.show(message: "", duration: 5.0)
```

Installation
---

### CocoaPods

To integrate JonAlert to your project using CocoaPods, specify it in your `Podfile`:

```ruby
target '<Your Target Name>' do
    pod 'JonAlert', :git => 'https://github.com/jonSurrey/JonAlert.git', :branch => 'master'
end
```

Then, run the following command:

```bash
$ pod install
```

### Manual installation

First download the "JonAlert" folder. Then, in Xcode, right-click on the root of your project node in the project navigator. Click "Add Files" to “YOURPROJECTNAME”. In the file chooser, navigate to where "Jon Alert" folder is and select JonAlert.xcodeproj. Click "Add" to add JonAlert.xcodeproj as a sub-project.

Select the top level of your project node to open the project editor. Click the YOUR_PROJECT_NAME target, and then go to the General tab.

Scroll down to the Embedded Binaries section. Drag JonAlert.framework from the Products folder of JonAlert.xcodeproj onto this section.

Clean and rebuild the project and you should be good to go!

Collaboration
---

This is a simple libray that I created to help myself in my own work since I didnt find any other that would do what I wanted. I know that there is still here a lot of space for improvements and adding new features, so please, any ideas or issues, feel free to collaborate!

## Author

Jonathan Martins, jon.martinsu@gmail.com

## License

JonAlert is available under the MIT license. See the LICENSE file for more info.
