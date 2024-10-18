# Swift View Query
## Vquery Features
* Vquery provides a query service for views under UIKit in Swift.
* Vquery supports xib layouts well.
* Supports SPM and CocoaPods management.

## Installation
- Manual import of the file `Vquery.swift`
```swift
import Vquery
```
- SPM(Swift Package Manager):
    - Add：https://github.com/Meterwhite/VquerySwift
- CocoaPods:
    - pod 'Vquery'

## Sample Code

- Query by matching type and condition:
```swift
someView.vquery(ofType: UILable.self){ $0.text == "2024" }
```

- Query sibling views by matching type and condition:
```swift
someView.vquerySibling(ofType: UILable.self){ $0.text == "2024" }
```

- Work with views laid out in xib:
```swift
someView.vqueryByInspector(ofType: UILabel.self, tag: row, accessibilityLabel: "row.title"){ $0.. }
```

## More Details
- Check out the Demo:
    - 点击`< > Code`-> Download ZIP
    - Open the project `Vquery-demo`