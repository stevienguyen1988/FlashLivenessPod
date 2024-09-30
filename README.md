# FlashLiveness

The mobile iOS SDK of FlashLiveness.

## Example

To run the example project, see [a link](https://github.com/stevienguyen1988/livenessCloudSample.git)

## Requirements

iOS >= 11.0, Objc or Swift

## Installation

### Cocoapod
To install FlashLiveness, simply add the following line to your Podfile:

```ruby
pod 'FlashLiveness', :git => 'https://github.com/stevienguyen1988/FlashLivenessPod.git'
```

### Manual
Step 1: Drag the FlashLiveness.xcframework into your app, check "Copy Items if needed"

Step 2: Open your project target, in General tab, see the Frameworks, Libraries, and Embedded Content, make sure FlashLiveness.xcframework that is Embeded and Sign

## Implement code

Step 1: create a livenessDetector variable
```swift
var livenessDetector: LivenessUtilityDetector?
```

Step 2: init **livenessDetector** in **viewDidLoad**
```swift
override func viewDidLoad() {
    super.viewDidLoad()

    self.livenessDetector = LivenessUtil.createLivenessDetector(previewView: self.previewView, mode: .online, delegate: self)
}
```

Step 3: in **viewWillAppear**, call function to start liveness
```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    do {
        try self.livenessDetector?.getVerificationRequiresAndStartSession(transactionId: self.transactionId)
    } catch{
        
    }
}
```

Step 4: in **viewWillDisappear**, call function to stop liveness
```swift
override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.livenessDetector?.stopLiveness()
}
```

## Authors

* **nhatnuoc** - *QTS*
