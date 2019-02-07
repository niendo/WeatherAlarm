//
//  AlarmPresenter.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
protocol AlarmPresenterInterface {
    func viewDidLoad()
    func reloadView()
}

class AlarmPresenter {
    var view: AlarmViewControllerInterface?
    let router: AlarmRouterInterface
    let interactor: AlarmInteractorInputInterface
    let weatherInteractor: WeatherInteractorInputInterface
    var emailValidated = false
    var passwordValidated = false
    
    init(router: AlarmRouterInterface, interactor: AlarmInteractor, weatherInteractor: WeatherInteractor) {
        self.interactor = interactor
        self.weatherInteractor = weatherInteractor
        self.router = router
    }
}

extension AlarmPresenter: AlarmPresenterInterface {
    func recoverPasswordClicked() {
        //        router.showRecoverPasswordViewController()
    }
    
    func viewDidLoad() {
//        self.view?.enableLoginButton(true)
    }
    
    func registerClicked() {
        //        router.showRegisterViewController()
    }
    
    func reloadView(){
        self.router.reloadView()
    }
    
}

extension AlarmPresenter: AlarmInteractorOutputInterface {
    func unauthenticated() {
        
    }
    
    func userLogged(token: String) {
        self.router.reloadView()
    }
    
    func loginError(error: String) {
        self.view?.makeError(title: "", error: error)
    }
}

