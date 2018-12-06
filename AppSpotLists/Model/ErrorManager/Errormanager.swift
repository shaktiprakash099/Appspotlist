//
//  Errormanager.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import UIKit
extension Error {
    
    static func serviceError(_ errorMessage: String) -> NSError {
        return NSError(domain: "Local Error", code: 1001, userInfo: [NSLocalizedDescriptionKey: errorMessage])
    }
    
    
    static func internalServerError(errorCode : Int) -> NSError {
        return NSError(domain: Configuration.ERROR_DOMAIN, code: errorCode, userInfo: [NSLocalizedDescriptionKey: "Internal Server Error Please try again after sometimes "])
    }
    
    static func nodataResponseError(errorCode : Int) -> NSError {
        return NSError(domain: Configuration.ERROR_DOMAIN, code: errorCode, userInfo: [NSLocalizedDescriptionKey: "No response from server .Kindly Check your parameters "])
    }
    
    static func unknownError(errorCode : Int) -> NSError {
        return NSError(domain: Configuration.ERROR_DOMAIN, code: 1001, userInfo: [NSLocalizedDescriptionKey: "Somethingwent wrong Please try again after sometimes"])
    }
    
}
