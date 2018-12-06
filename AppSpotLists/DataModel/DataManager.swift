//
//  DataManager.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/6/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import Foundation

class DataManager{
    static let shareinstance = DataManager()
    //MARK: FetchItemLists
    /*
     * [This function  is used to fetch ItemList details from UserDefaults]
     ***
     */
    func retriveSaveditemslists()->[ItemsDetailsLists]?{
        
        let defaults = UserDefaults.standard
        if let savedPeople = defaults.object(forKey: "people") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                let data = try jsonDecoder.decode([ItemsDetailsLists].self, from: savedPeople)
                return data
                
            } catch {
                print("Failed to load people")
                return nil
            }
        }
        
        return nil
    }
    
    //MARK: SaveItemLists
    /*
     * [This function  is used to save ItemList details in  UserDefaults]
    */
    func saveitemLists(with itemlists:[ItemsDetailsLists]){
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(itemlists) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "people")
        } else {
            print("Failed to save people.")
        }
    }
    
}
