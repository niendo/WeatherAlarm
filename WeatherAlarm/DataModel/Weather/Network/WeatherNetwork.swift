//
//  WeatherNetwork.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper
class WeatherNetwork: BaseNetworkObject {
    var weather: String?
    var rain: String?
    
        public required convenience init?(map: Map) {
            self.init()
        }
    
        public override func mapping(map: Map) {
            weather <- map[ProjectConstants.OutputKeys.weather]
            rain <- map[ProjectConstants.OutputKeys.rain]
    
        }
}
