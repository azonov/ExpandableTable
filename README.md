![AZExpandable](https://raw.githubusercontent.com/azonov/expandableTable/master/logo_long.png)

**AZExpandable** is a lightweight proxy for UITableView to expand cells. It incapsulates native NSProxy mechanism inside and gives swifty api outside.
<br />
<br />General advantages: **No Subclassing**, **No Swizzling**, **Easy to intagrate**

- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)

## Requirements

- iOS 8.0+
- Xcode 9.2+
- Swift 4.0+

## Communication

- If you'd like to **ask a general question**, use [Twitter](http://twitter.com/avzonov).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build AZExpandable.

To integrate AZExpandable into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target '<Your Target Name>' do
    pod 'AZExpandable'
end
```

Then, run the following command:

```bash
$ pod install
```

## Usage


```swift
private var expandableTable: ExpandableTable!// Expanding Table Proxy

override func viewDidLoad() {
    super.viewDidLoad()
    // infoProvider - UITableViewDelegate & UITableViewDataSource
    expandableTable = ExpandableTable(with: tableView, infoProvider: self)
}

func expandCell(at indexPath: IndexPath) {
    let cellClosure: CellClosure = { (IndexPath) -> (UITableViewCell) in
    	//Your custom expanding cell
        return self.tableView.dequeueReusableCell(withIdentifier: "Identifier", for: indexPath)
    }
    expandableTable.expandCell(ExpandedCellInfo(for: indexPath, cellType: .custom(cellClosure)))
}

func unexpandCell() {
	expandableTable.unexpandCell()
}
```


## License

AZExpandable is released under the MIT license. [See LICENSE](https://github.com/azonov/expandableTable/blob/master/LICENSE) for details.
