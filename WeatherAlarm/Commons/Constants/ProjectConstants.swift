//
//  ProjectConstants.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
struct ProjectConstants {
    struct Endpoints {
        static let weatherCityUrl = "/data/2.5/weather?q="
    }
    
    struct InputKeys {
        static let a = "a"
    }
    
    struct OutputKeys {
        static let weather = "weather"
        static let rain = "rain"
        
        static let code = "code"
        static let message = "message"
        static let timestamp = "timestamp"
        static let traceId = "traceId"
        static let path = "path"
        static let detail = "detail"
    
    }
}
