//
//  ApiHelperClass.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit

class ApiHelperClass: NSObject {
    
    static let shareinstance = ApiHelperClass()

    func getAppSpotPeopleDetails(userEmailid:String, onSuccess:@escaping(AppSpotsDetails)->Void, onError:@escaping(Error)->Void) {
        
        let url = URL(string: "\(Configuration.BASE_URL)")
        let inputParams = InputParams(emailId:userEmailid)
        let encoder = JSONEncoder()

        encoder.outputFormatting = .prettyPrinted
        
        var  jsonData = Data()
        do {
            jsonData = try encoder.encode(inputParams)
            print(String(data: jsonData, encoding: .utf8)!)
        } catch let error {
            print("Error\(error)")
            onError(error)
        }
        URLSessionManager.share.postRawRequest(with: url!, body: jsonData, onSuccess: { (data) in
            do {
                let response = try JSONDecoder().decode(AppSpotsDetails.self, from: data)
                onSuccess(response)
            } catch let error {
                print(error)
                onError(error)
            }
        }) { (error) in
            onError(error)
        }
    }
}
