//
//  TableViewCustomDataSource.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/6/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

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


extension TableViewCustomDataSource where Model == ItemsDetailsLists{
    
    static func displayData(for itemLists:[ItemsDetailsLists],withCellidentifier reuseIdentifier: String)->TableViewCustomDataSource{
        return TableViewCustomDataSource(models: itemLists, reuseIdentifier: reuseIdentifier, cellConfigurator: { (data, cell ) in
            let itemcell:ItemListsTableViewCell = cell as! ItemListsTableViewCell
            itemcell.setupParameters(itemlist: data)
        })
    }
    
}
