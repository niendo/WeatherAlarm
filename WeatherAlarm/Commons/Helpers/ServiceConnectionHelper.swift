//
//  ServiceConnectionHelper.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import UIKit

typealias SuccessCompletionBlock = (_ object: AnyObject) -> Void
typealias FailureCompletionBlock = (_ error: Error) -> Void
typealias BoolServiceHandler = (Bool, AnyObject) -> Void
typealias IntServiceHandler = (Int, AnyObject) -> Void

enum HttpPetitionMethod: String {
    case get
    case post
    case put
    case patch
    case delete
    
    func stringify() -> String {
        return self.rawValue.uppercased()
    }
}

enum MediaType: String {
    case image
    case video
    case other
    
    func stringify() -> String {
        return self.rawValue.uppercased()
    }
}

protocol ServiceConnectionHelper {
    
}

extension ServiceConnectionHelper {
    
    func getUserHeaders() -> [String: String] {
        return
            [
                "content-type": "application/json",
                "cache-control": "no-cache",
                "Accept": "application/json;charset=UTF-8",
                "Accept-Language": "es"
        ]
    }
    
    func makePetition(urlString: String, method: String, headers: [String: String]?, params: [String: AnyObject?]?, handle: @escaping IntServiceHandler, refresh: Bool = false) {
        
        var newHeaders = headers
        if newHeaders == nil {
            newHeaders = getUserHeaders()
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        print("request url \(url)")
        print("params \(String(describing: params))")
        print("headers \(String(describing: newHeaders)))")
        print("method \(method)")
        
        request.allHTTPHeaderFields = newHeaders
        request.httpMethod = method
        var newParams: [String: AnyObject] = [:]
        if params != nil {
            for param in params! where param.value != nil {
                print("not null \(param)")
                newParams[param.key] = param.value
            }
            request.httpBody = try? JSONSerialization.data(withJSONObject: newParams, options: [])
        }
        request.timeoutInterval = 300
        
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        
        
        Alamofire.request(request).responseJSON { response in
            if let requestBody = request.httpBody {
                
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                    
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if utf8Text.contains("<body>") {
                    let text1 = utf8Text.components(separatedBy: "<body>")
                    let text2 = text1[1].components(separatedBy: "</body>")
                    print("Data: \(text2[0])")
                } else {
                    print("Data: \(utf8Text)")
                }
                
                print("headers AFTER \(String(describing: newHeaders))")
            }
            print("RESPONSE CODE: \(response.response?.statusCode ?? 0)")
            
            if response.response != nil {
                if let responseCode = response.response?.statusCode {
                    if responseCode < 300  {
                        handle(responseCode, response.result.value as AnyObject)
                    } else {
                        if let error = Mapper<NetworkError>().map(JSONObject: response.result.value) {
                            error.responseCode = responseCode
                            
                           
                            handle(-1, "Session expired" as AnyObject)
                            let errorCrashlytics = NSError(domain: "Session expired", code: 3, userInfo: nil)
//                                        Crashlytics.sharedInstance().recordError(errorCrashlytics)
   
                        }
                    }
                    
                } else {
                    handle(-1, "Server error" as AnyObject)
                    let error = NSError(domain: "Unkown server error", code: 4, userInfo: ["responseString": response.debugDescription])
//                    Crashlytics.sharedInstance().recordError(error)
                }
            } else {
                handle(-1, "Server error" as AnyObject)
                let error = NSError(domain: "Unkown server error", code: 5, userInfo: ["responseString": "null response"])
//                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
    
    func makePetitionObject(urlString: String, method: String, headers: [String: String]?, params: AnyObject, handle: @escaping IntServiceHandler, refresh: Bool = false) {
        
        
        if let _ = params as? [AnyObject] {
            
        }
        var newHeaders = headers
        if newHeaders == nil {
            newHeaders = getUserHeaders()
        }
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        print("request url \(url)")
        print("params \(String(describing: params))")
        print("headers \(String(describing: newHeaders)))")
        print("method \(method)")
        
        request.allHTTPHeaderFields = newHeaders
        request.httpMethod = method
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.timeoutInterval = 300
        
        var now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "HH:mm:ss"
        Alamofire.request(request).responseJSON { response in
            if let requestBody = request.httpBody {
                
                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: requestBody, options: [])
                    print("Array: \(jsonArray)")
                }
                catch {
                    print("Error: \(error)")
                }
            }
            
            now = Date()
            print("TIME STAMP AFTER PETITION \(formatter.string(from: now))")
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                if utf8Text.contains("<body>") {
                    let text1 = utf8Text.components(separatedBy: "<body>")
                    let text2 = text1[1].components(separatedBy: "</body>")
                    print("Data: \(text2[0])")
                } else {
                    print("Data: \(utf8Text)")
                }
            }
            //            if response.response != nil {
            //                print("RESPONSE CODE: \(response.response?.statusCode ?? 0)")
            //                if let responseCode = response.response?.statusCode {
            //                    handle(responseCode, response.result.value as AnyObject)
            //
            //                } else {
            //                    let error = Mapper<NetworkErrorOutput>().map(JSONObject: response.result.value)
            //                    if error != nil {
            //                        handle(-1, error!)
            //                    } else {
            //                        handle(-1, "Something went wrong" as AnyObject)
            //                    }
            //                }
            //            } else {
            //                handle(-1, "Server error" as AnyObject)
            //            }
            if response.response != nil {
                if let responseCode = response.response?.statusCode {
                    if responseCode == 200 {
                        handle(responseCode, response.result.value as AnyObject)
                    } else {
                        if let error = Mapper<NetworkError>().map(JSONObject: response.result.value) {
                            error.responseCode = responseCode

                            handle(-1, "Session expired" as AnyObject)
                            let errorCrashlytics = NSError(domain: "Session expired", code: 3, userInfo: nil)
//                                        Crashlytics.sharedInstance().recordError(errorCrashlytics)
                        }
                    }
                } else {
                    handle(-1, "Server error" as AnyObject)
                    let error = NSError(domain: "Unkown server error", code: 4, userInfo: ["responseString": response.debugDescription])
//                    Crashlytics.sharedInstance().recordError(error)
                }
            } else {
                handle(-1, "Server error" as AnyObject)
                let error = NSError(domain: "Unkown server error", code: 5, userInfo: ["responseString": "null response"])
//                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
}
