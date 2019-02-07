//
//  WeatherInteractor.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper
protocol WeatherInteractorInputInterface {
    func getWeather()
}



protocol WeatherInteractorOutputInterface: class{
    func getWeatherSuccess(_ weatherOutput: WeatherNetwork)
    func getWeatherError(error: String)
}



class WeatherInteractor {
    
    let weatherDataSource: WeatherDataSource
    weak var weatherInteractorOutput: WeatherInteractorOutputInterface?
    
    init(weatherDataSource: WeatherDataSource) {
        self.weatherDataSource = weatherDataSource
    }
}

extension WeatherInteractor: WeatherInteractorInputInterface {
    
    
    func getWeather() {
        
        if !Reachability.isConnectedToNetwork(){
//            self.userInteractorOutput?.getUserError(error: "Sin conexión")
        }else{
            self.weatherDataSource.getWeather(params: [:]) {  [weak self] (code, response) in
                switch code {
                case 200, 201:
                    if let weatherOutput = Mapper<WeatherNetwork>().map(JSONObject
                        : response) {
                        self?.weatherInteractorOutput?.getWeatherSuccess(weatherOutput)
                    } else {
                        self?.weatherInteractorOutput?.getWeatherError(error: "Error de servicio")
                    }
                default:
                    if let error = response as? NetworkError {
              
                        self?.weatherInteractorOutput?.getWeatherError(error: error.message ?? "")
                        
                    } else {
                        self?.weatherInteractorOutput?.getWeatherError(error: "Error de servicio")
                    }
                }
            }
        }
    }
    
}
