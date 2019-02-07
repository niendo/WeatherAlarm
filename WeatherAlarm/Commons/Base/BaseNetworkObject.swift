//
//  BaseNetworkObject.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper
class BaseNetworkObject: NSObject, Mappable {
    
        public required convenience init?(map: Map) {
            self.init()
        }
    
        public func mapping(map: Map) {
    
        }
}
