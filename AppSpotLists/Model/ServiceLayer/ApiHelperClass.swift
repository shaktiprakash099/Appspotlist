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

    func getAppSpotPeopleDetails(userEmailid:String ,completionHandler:@escaping(AppSpotsDetails?,Error?)->Void)->Void {
        
        let url = URL(string: "\(Configuration.BASE_URL)")
        let inputParams = InputParams(emailId:userEmailid)
        let encoder = JSONEncoder()

        encoder.outputFormatting = .prettyPrinted
        
        var  jsonData = Data()
        do {
            jsonData = try encoder.encode(inputParams)
            print(String(data: jsonData, encoding: .utf8)!)
        }
        catch let error {
            print("Error\(error)")
            completionHandler(nil, error)
        }
        
        URLSessionManager.share.postRawRequest(with: url!, body: jsonData) { (data, error) in
            
            if error != nil {
                completionHandler(nil,error)
            }
            else{
                do {
                    let response = try JSONDecoder().decode(AppSpotsDetails.self, from: data! as Data )
                    completionHandler(response,error)
                }
                catch let error {
                    print(error)
                    completionHandler(nil,error)
                }
            }
            
        }
        
    }
}
