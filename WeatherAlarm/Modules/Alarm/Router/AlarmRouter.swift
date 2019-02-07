import UIKit
protocol AlarmRouterInterface{
    func reloadView()
}

class AlarmRouter {
    let mainRouter: BaseRouterInterface
    init(mainRouter: BaseRouterInterface) {
        self.mainRouter = mainRouter
    }
}

extension AlarmRouter: AlarmRouterInterface {
    func reloadView() {
        
    }
}

extension AlarmRouter: RouterFactory {
    
    static func create(withMainRouter mainRouter: BaseRouterInterface) -> UIViewController {
        let router = AlarmRouter(mainRouter: mainRouter)
        let weatherDataSource = WeatherDataSource()
        let alarmDataSource = AlarmDataSource()
        let interactor = AlarmInteractor(alarmDataSource: alarmDataSource)
        let weatherInteractor = WeatherInteractor(weatherDataSource: weatherDataSource)
        let presenter = AlarmPresenter(router: router, interactor: interactor, weatherInteractor: weatherInteractor)
//        weatherInteractor.weatherInteractorOutput = presenter
        
        let view = AlarmViewController(nibName: "LoginViewController", bundle: nil, presenter: presenter)
        presenter.view = view
        return view
    }
}
