# DevOptions

[![Version](https://img.shields.io/cocoapods/v/DevOptions.svg?style=flat)](https://cocoapods.org/pods/DevOptions)
[![License](https://img.shields.io/cocoapods/l/DevOptions.svg?style=flat)](https://cocoapods.org/pods/DevOptions)
[![Platform](https://img.shields.io/cocoapods/p/DevOptions.svg?style=flat)](https://cocoapods.org/pods/DevOptions)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0+
- File "Pods-acknowledgement.plist" located in Target's Pods directory.

## Installation

DevOptions is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DevOptions'
```

## Usage

1. Add the "Pods-acknowledgement.plist" file to your project. You can find this file in the Pods directory of your target (Pods -> Target Support Files -> Pods-YourTarget). Ensure that the file is in the "Copy Bundle Resources" of your target project. 
Note: Until a future version, you'll need to do this manually each time you update your Pods.

2. Configure the Pod in AppDelegate's didFinishLaunchingWithOptions:

```swift

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.

    let configurations = DevOptionsConfigurations()
    configurations.companyLogo = UIImage(named: "company_logo")
    configurations.companyWebsite = "https://www.nomadesolutions.com/"
    configurations.password = "1234"
    //configurations.mainStoryboardName = "Main" //In case you use storyboards
    //Other configurations are already set, but available for customization

    DevOptions.configure(configurations, baseUrls: [UIApplication.serverBaseUrl(), UIApplication.otherBaseUrl()]) {
        /* 
            What you want to do when the Developper Mode is activated or deactivated
        */
        
        // To update DevOptions view controller.
        DevOptions.baseUrls = [UIApplication.serverBaseUrl(), UIApplication.otherBaseUrl()]
    }
    return true
}
```

3. Add the EndorsementView to your UI:

Programmatically:

```swift
let endorsementView = EndorsementView()
view.addSubview(endorsementView)

endorsementView.snp.makeConstraints { (make) in
    make.left.equalTo(view.snp.left)
    make.right.equalTo(view.snp.right)
    make.bottom.equalTo(view.snp.bottom)
}
```
or:
```swift
let endorsementView = EndorsementView(CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60))
view.addSubview(endorsementView)
```

From Storyboard:
Set a custom class for your view (Class: EndorsementView, Module: DevOptions). XCode should select the module automatically.

4. Access the DevOptions by long pressing both company  and licenses logos.

## Author

Nomade Solutions Mobiles, info@nomadesolutions.com

## License

DevOptions is available under the MIT license. See the LICENSE file for more info.
