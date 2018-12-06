//
//  PostBodyDatamodel.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit

struct AppSpotsDetails:Codable {
    var items:[ItemsDetailsLists]
    
}
struct ItemsDetailsLists:Codable {
   var emailId: String
   var imageUrl: String
   var firstName: String
   var lastName: String
    
}

struct InputParams:Codable {
    var emailId:String
}

