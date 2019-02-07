//
//  WeatherDataSource.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol WeatherDataSourceInterface: ServiceConnectionHelper {
    func getWeather(params: [String: AnyObject?], handle: @escaping IntServiceHandler)
}

class WeatherDataSource {
    var weatherCityUrl: String {
        return EnvironmentConstants.weatherApiUrl+ProjectConstants.Endpoints.weatherCityUrl
    }
}
extension WeatherDataSource: WeatherDataSourceInterface {
    func getWeather(params: [String: AnyObject?], handle: @escaping IntServiceHandler) {
        makePetition(urlString: weatherCityUrl, method: HttpPetitionMethod.post.stringify(), headers: nil, params: params, handle: handle)
    }

}
