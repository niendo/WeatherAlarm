//
//  AlarmInteractor.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import ObjectMapper
protocol AlarmInteractorInputInterface {
}



protocol AlarmInteractorOutputInterface: class{

}



class AlarmInteractor {
    
    let alarmDataSource: AlarmDataSource
    weak var alarmInteractorOutput: AlarmInteractorOutputInterface?
    
    init(alarmDataSource: AlarmDataSource) {
        self.alarmDataSource = alarmDataSource
    }
}

extension AlarmInteractor: AlarmInteractorInputInterface {

    
}
