# Constraints

[![Version](https://img.shields.io/cocoapods/v/Constraints.svg?style=flat)](http://cocoapods.org/pods/Constraints)
[![License](https://img.shields.io/cocoapods/l/Constraints.svg?style=flat)](http://cocoapods.org/pods/Constraints)
[![Platform](https://img.shields.io/cocoapods/p/Constraints.svg?style=flat)](http://cocoapods.org/pods/Constraints)

## Example

```swift
// pinning and adding subviews
        
backgroundView.constraint(on: view)
    .pin()

blueRect.constraint(on: view)
    .height(c: 40)
    .safePin(.top, .left, .bottom)


centerSquare.constraint(on: view)
    .center()
    .square(to: 100)
    
```

## Installation

Constraints is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Constraints'
```

## Author

Serhiy Vysotskiy

## License

Constraints is available under the MIT license. See the LICENSE file for more info.
