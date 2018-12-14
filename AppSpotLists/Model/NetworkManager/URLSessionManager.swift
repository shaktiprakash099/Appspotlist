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
    func postRequest(with url: URL, body: String, onSuccess:@escaping(Data)-> Void, onError:@escaping(Error)-> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("json/application", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = body.data(using: .utf8)
        
        self.sessionTask(urlRequest: urlRequest, onSuccess: { (data) in
            onSuccess(data)
        }) { (error) in
            onError(error)
        }
    }
    
    //MARK: Post raw methods
    func postRawRequest(with url: URL, body: Data, onSuccess:@escaping(Data)-> Void, onError:@escaping(Error)-> Void) {
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("\(body.count)", forHTTPHeaderField: "Content-Length")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = body
        
        self.sessionTask(urlRequest: urlRequest, onSuccess: { (data) in
            onSuccess(data)
        }) { (error) in
            onError(error)
        }
    }
    
    
    //MARK: GET Methods
    func getRequest(with url: URL, onSuccess:@escaping(Data)-> Void, onError:@escaping(Error)-> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        self.sessionTask(urlRequest: urlRequest, onSuccess: { (data) in
            onSuccess(data)
        }) { (error) in
            onError(error)
        }
    }
    
    func sessionTask(urlRequest: URLRequest, onSuccess:@escaping(Data)-> Void, onError:@escaping(Error)-> Void) {
        let sessionTask = self.getSharedSession()
        sessionTask.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                onError(NSError.serviceError(error!.localizedDescription))
                return
            }
            
            let httpResponse: HTTPURLResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                if let data = data {
                    onSuccess(data)
                } else {
                    //return error
                }
            } else {
                switch (httpResponse.statusCode) {
                    
                case 500:
                    onError(NSError.internalServerError(errorCode: 500))
                    break
                default:
                    onError(NSError.unknownError(errorCode: httpResponse.statusCode))
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


