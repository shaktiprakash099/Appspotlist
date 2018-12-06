//
//  ItemsListsViewController.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit
import SVProgressHUD

class ItemsListsViewController: UIViewController {
    
    private var  itemLists = [ItemsDetailsLists]()
    private var dataSource:TableViewCustomDataSource<ItemsDetailsLists>?
    var loggedInUserEmailid:String?

    @IBOutlet weak var itemListTableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.itemListTableview.rowHeight = 80
        retriveLocalData()
     
    }
    
    @IBAction func backAction(_ sender: Any) {
    self.navigationController?.popViewController(animated: true)
    }
    
    func retriveRemoteData(){
        ApiHelperClass.shareinstance.getAppSpotPeopleDetails(userEmailid: loggedInUserEmailid ?? "") {[unowned self] (response, error) in
            DispatchQueue.main.async {
                
                SVProgressHUD.dismiss()
                
                if error != nil {
                    
                    AlertManager.shareinstance.showAlert(on: self, alertmessageTitle: "Error occured ", alertmessageContent: error?.localizedDescription ?? "")
                }
                else{
                    
                    self.renderTableViewdataSource(response?.items ?? [])
                    DataManager.shareinstance.saveitemLists(with: response?.items ?? [])

                }

            }
        }
    }
    
    func renderTableViewdataSource(_ itemlists:[ItemsDetailsLists]){
       
        dataSource = .displayData(for: itemlists, withCellidentifier: "ItemListsTableViewCell")
        self.itemListTableview.dataSource = dataSource
        self.itemListTableview.reloadData()
        
    }
    
    //MARK: RetriveLocalData
    func retriveLocalData(){
        
        guard let datalists =  DataManager.shareinstance.retriveSaveditemslists() else {
            
            SVProgressHUD.show(withStatus: "Fetching User details")
            self.retriveRemoteData()
            return
        }
        self.renderTableViewdataSource(datalists)
        DispatchQueue.global(qos: .background).async { [unowned self] in
            self.retriveRemoteData()
        }
    }
    
}

