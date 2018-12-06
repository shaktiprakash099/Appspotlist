//
//  URLSessionManager.swift
//  AppSpotLists
//
//  Created by GLB-253 on 12/5/18.
//  Copyright © 2018 IOSISFUN. All rights reserved.
//

import Foundation
import UIKit

class URLSessionManager: NSObject {
    
    static let share = URLSessionManager()
    
    private func configureDefaultSession() -> URLSessionConfiguration {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        return sessionConfig
    }
    
    private func configureBackgroundSession(_ identifier: String) -> URLSessionConfiguration {
        
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: identifier)
        return sessionConfig
    }
    
    private func getSharedSession() -> URLSession {
        let configuration = self.configureDefaultSession()
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        return session
    }
    
    //MARK: Post Request methos
    func postRequest(with url: URL, body: String, completionHandler: @escaping (Data?, NSError?) -> Void) -> Void {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("json/application", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = body.data(using: .utf8)
        
        let  sessionTask = self.getSharedSession()
        
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(nil, NSError.serviceError(error!.localizedDescription))
                
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                completionHandler(data, nil)
                
            }
            else {
                switch (httpResponse.statusCode) {
            
                case 500:
                    completionHandler(nil,NSError.internalServerError(errorCode: 500))
                    break
                default:
                    completionHandler(nil, NSError.unknownError(errorCode: httpResponse.statusCode))
                }
                
            }
            }.resume()
        sessionTask.finishTasksAndInvalidate()
        
    }
    
    //MARK: Post raw methods
    func postRawRequest(with url: URL, body: Data, completionHandler: @escaping (Data?, NSError?) -> Void) -> Void {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body
        
        
        let sessionTask = URLSession.shared
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(nil, NSError.serviceError(error!.localizedDescription))
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                completionHandler(data, nil)
            }
            else {
                switch (httpResponse.statusCode) {
              
                case 500:
                    completionHandler(nil,NSError.internalServerError(errorCode: 500))
                    break
                case 404:
                    completionHandler(nil,NSError.nodataResponseError(errorCode: 404))
                    break
                case 400:
                    completionHandler(nil,NSError.nodataResponseError(errorCode: 400))
                    break
                default:
                    completionHandler(nil, NSError.unknownError(errorCode: httpResponse.statusCode))
                }
            }
            }.resume()
        sessionTask.finishTasksAndInvalidate()
        
        
    }
    
    
    //MARK: GET Methods
    func getRequest(with url: URL, completionHandler: @escaping (Data?, NSError?) -> Void) -> Void {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        
        let sessionTask = self.getSharedSession()
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completionHandler(nil, NSError.serviceError(error!.localizedDescription))
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                
                completionHandler(data, nil)
            }
            else {
                switch (httpResponse.statusCode) {
                case 500:
                    completionHandler(nil,NSError.internalServerError(errorCode: 500))
                    break
                default:
                    completionHandler(nil, NSError.unknownError(errorCode: httpResponse.statusCode))
                }
            }
            }.resume()
        sessionTask.finishTasksAndInvalidate()
    }
}

extension URLSessionManager: URLSessionDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        
    }
    
    
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Error occred")
    }
}


