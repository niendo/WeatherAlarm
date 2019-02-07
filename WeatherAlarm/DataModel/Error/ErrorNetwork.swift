//
//  ErrorNetwork.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper

class NetworkError: BaseNetworkObject {
    
    var code: String?
    var message: String?
    var timestamp: String?
    var traceId: String?
    var path: String?
    var detail: String?
    var responseCode: Int?
    
    public required convenience init?(map: Map) {
        self.init()
    }
    
    public override func mapping(map: Map) {
        code <- map[ProjectConstants.OutputKeys.code]
        message <- map[ProjectConstants.OutputKeys.message]
        timestamp <- map[ProjectConstants.OutputKeys.timestamp]
        traceId <- map[ProjectConstants.OutputKeys.traceId]
        path <- map[ProjectConstants.OutputKeys.path]
        detail <- map[ProjectConstants.OutputKeys.detail]
    }
    
    func isSessionExpired() -> Bool {
        return responseCode == 401
    }
}
