//
//  BaseRouter.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import Foundation
import UIKit

protocol BaseRouterInterface {
    func create(navigationController : UIViewController)
    func present(viewController: UIViewController, animated: Bool)
    func pushToNavigation(viewController: UIViewController, animated: Bool)
    func previousViewController()
    func goBackTo(viewController: UIViewController, hasNavigationBar: Bool)
    func currentViewController() -> UIViewController?
}

protocol RouterFactory {
    static func create(withMainRouter mainRouter: BaseRouterInterface) -> UIViewController
}

class BaseRouter {
    let window: UIWindow
    var presentViewController: UIViewController?
    var rootViewController: UIViewController {
        guard let rootViewController = window.rootViewController else {
            fatalError("There is no rootViewController installed on the window")
        }
        return rootViewController
    }
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension BaseRouter {
    
    func presentRootViewController() {
        showAlarm()
    }
    
    func showAlarm() {
        let alarmViewController = AlarmRouter.create(withMainRouter: self)
        firstViewController(viewController: alarmViewController)
        presentViewController = alarmViewController
    }

    
    
    private func getVisibleViewController(_ rootViewController: UIViewController?) -> UIViewController? {
        
        var rootVC = rootViewController
        if rootVC == nil {
            rootVC = UIApplication.shared.keyWindow?.rootViewController
        }
        
        if rootVC?.presentedViewController == nil {
            return rootVC
        }
        
        if let presented = rootVC?.presentedViewController {
            if presented.isKind(of: UINavigationController.self) {
                let navigationController = presented as! UINavigationController
                return navigationController.viewControllers.last!
            }
            
            if presented.isKind(of: UITabBarController.self) {
                let tabBarController = presented as! UITabBarController
                return tabBarController.selectedViewController!
            }
            return getVisibleViewController(presented)
        }
        return nil
    }
}

extension BaseRouter: BaseRouterInterface {
    
    func currentViewController() -> UIViewController? {
        return presentViewController
    }
    
    
    func firstViewController(viewController: UIViewController){
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    func create(navigationController : UIViewController) {
        let rootViewController = UINavigationController(rootViewController: navigationController)
        window.rootViewController = rootViewController
        presentViewController = navigationController
    }
    
    func pushToNavigation(viewController: UIViewController, animated: Bool) {
        if  window.rootViewController?.navigationController == nil {
            if rootViewController is UINavigationController {
                CastUtility.castSafely(rootViewController, expectedType: UINavigationController.self).pushViewController(viewController, animated: animated)
            } else if rootViewController.navigationController != nil {
                rootViewController.navigationController!.pushViewController(viewController, animated: animated)
            }
        } else {
            window.rootViewController?.navigationController?.pushViewController(viewController, animated: animated)
        }
        presentViewController = viewController
    }
    
    func present(viewController: UIViewController, animated: Bool) {
        rootViewController.present(viewController, animated: animated, completion: nil)
        presentViewController = viewController
    }
    
    func previousViewController(){
        if let nav = rootViewController as? UINavigationController {
            nav.popViewController(animated: true)
        } else {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
    
    func goBackTo(viewController: UIViewController, hasNavigationBar: Bool) {
        let navController = UINavigationController(rootViewController: viewController)
        navController.isNavigationBarHidden = !hasNavigationBar
        
        window.rootViewController = navController
        presentViewController = viewController
    }
}
