//
//  EnvironmentConstants.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
struct EnvironmentConstants {
    
    static let development = "development"
    static let production = "production"
    
    static var name: String {
        guard let name = Bundle.main.infoDictionary!["ENVIRONMENT_NAME"] as? String else {
            return "no data"
        }
        
        return name
    }
    
    static var weatherApiUrl: String {
        guard let host = Bundle.main.infoDictionary!["WEATHER_API_URL"] as? String else {
            return "no hostUrl data"
        }
        return host.replacingOccurrences(of: "\\", with: "")
    }
    
    static var clientSecret: String {
        guard let secret = Bundle.main.infoDictionary!["CLIENT_SECRET"] as? String else {
            return "no secret"
        }
        return secret
    }
    
    static var isDevelopment: Bool {
        return name == development
    }
    
    static var packageName: String {
        return Bundle.main.bundleIdentifier ?? ""
    }
    
    static var appVersion: String {
        guard let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String else {
            return "no version data"
        }
        return version
    }
    
    static var appBuild: String {
        guard let version = Bundle.main.infoDictionary!["CFBundleVersion"] as? String else {
            return "no version data"
        }
        return version
    }
    
    
    static var clientId: String {
        guard let identifier = Bundle.main.infoDictionary!["CLIENT_ID"] as? String else {
            return "no data"
        }
        return identifier
    }
    
    
    
}
