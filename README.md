# Swift View Query
## Vquery Features
* Vquery provides a query service for views in both UIKit and AppKit for Swift.
* Vquery supports xib layouts well.
* Supports SPM and CocoaPods management.

## Installation
- Manual import of the file `Vquery.swift`
```swift
import Vquery
```
- SPM(Swift Package Manager):
```
https://github.com/Meterwhite/VquerySwift
```
- CocoaPods:
```ruby
    pod 'Vquery'
```

## Sample Code

- Query the view and perform some
```swift
someView.vquery{ $0.tag == index }.foreach{ $0.isHidden = true }
```

- Query by matching type and condition:
```swift
someView.vquery(ofType: MyLabel.self){ $0.yearTitle == "2024" }
```

- Query sibling views by matching type and condition:
```swift
someView.vquerySibling(ofType: MyLabel.self){ $0.yearTitle == "2024" }
```

- Work with views laid out in xib:
```swift
someView.vqueryByInspector(tag: index, accessibilityLabel: "Row Title")
```

## More Details
- Check out the Demo:
    - Click`< > Code`-> Download ZIP
    - Open the project `Vquery-demo`
