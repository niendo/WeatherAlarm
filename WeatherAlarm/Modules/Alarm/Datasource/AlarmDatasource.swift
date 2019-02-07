//
//  AlarmDatasource.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol AlarmDataSourceInterface: ServiceConnectionHelper {
    func getWeather(params: [String: AnyObject?], handle: @escaping IntServiceHandler)
}

class AlarmDataSource {
    var weatherCityUrl: String {
        return EnvironmentConstants.weatherApiUrl+ProjectConstants.Endpoints.weatherCityUrl
    }
}
extension AlarmDataSource: AlarmDataSourceInterface {
    func getWeather(params: [String: AnyObject?], handle: @escaping IntServiceHandler) {
        makePetition(urlString: weatherCityUrl, method: HttpPetitionMethod.post.stringify(), headers: nil, params: params, handle: handle)
    }
    
}
