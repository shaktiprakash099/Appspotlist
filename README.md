<a href="https://imgbb.com/"><img src="https://i.ibb.co/w6bshPz/Screen-Shot-2018-12-06-at-5-06-53-PM.png" alt="Screen-Shot-2018-12-06-at-5-06-53-PM" border="0"></a><br /><a target='_blank' href='https://poetandpoem.com/20-lines'></a><br />

**Appspotlist** is a simple ,clean iOS App demonstrating  how to make a custom datasource with generic datamodel type


![Xcode 9.0](https://img.shields.io/badge/Xcode-9.0%2B-blue.svg)
![iOS 8.0+](https://img.shields.io/badge/iOS-8.0%2B-blue.svg)
![Swift 4.0+](https://img.shields.io/badge/Swift-4.0%2B-orange.svg)

<a href="https://ibb.co/7Xtwc6t"><img src="https://i.ibb.co/TkMVXFM/Screen-Shot-2018-12-06-at-5-26-44-PM.png" alt="Screen-Shot-2018-12-06-at-5-26-44-PM" border="0"></a>&nbsp;
<a href="https://ibb.co/Y8Hs2j4"><img src="https://i.ibb.co/Dk024KP/Screen-Shot-2018-12-06-at-5-28-07-PM.png" alt="Screen-Shot-2018-12-06-at-5-28-07-PM" border="0"></a>

## How to Use 
Simply download or clone this project open in Xcode 9.0 or above hit Run button and there you go

## Which  ThirdParty libraries are  used  here 
Here i have used  two libraries SVProgressHUD and SDWebImage for Loading and Image downloading respectively using CocoaPods

### How to install those libraries using  CocoaPods

Add the following entry to your Podfile:

```rb
 pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git'
 pod 'SDWebImage', '~> 4.0'
```

Then run `pod install`.

##### What to learn about custom datasource
To make our controller clean and simple , i have used a separate datasource class for handling UITableViewDataSource delegate methods
and here this custom datasource class is generic means depending on your datamodeltype you can  use this class in your controller 
```swift
import UIKit

class TableViewCustomDataSource<Model>: NSObject,UITableViewDataSource{
    
    typealias CellConfigurator = (Model,UITableViewCell)-> Void
    var models:[Model]
    private let reuseIdentifier:String
    private let cellConfigurator: CellConfigurator
    init(models:[Model],reuseIdentifier:String,cellConfigurator:@escaping CellConfigurator) {
        
       self.models = models
       self.reuseIdentifier = reuseIdentifier
       self.cellConfigurator = cellConfigurator
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cellConfigurator(model,cell)
        return cell
    }
    
}
```
**Happy Coding**
