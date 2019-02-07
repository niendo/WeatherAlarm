//
//  BaseViewController.swift
//  WeatherAlarm
//
//  Created by Eduardo Nieto on 22/01/2019.
//  Copyright © 2019 Eduardo Nieto. All rights reserved.
//

import UIKit
protocol BaseViewControllerInterface {
    func showPreloader(isShown: Bool)
    func showError(title: String, text: String)
    func showErrorWithButtons(title: String, text: String)
}

class BaseViewController: UIViewController {
    @IBOutlet weak var topLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
//    var preloader: PreloaderView?
//    var errorView: ErrorView?
    
    @IBInspectable var hasNavigationBar: Bool = false
    var isKeyboard = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureParentView()
    }
    
    func configureParentView() {
        
        self.navigationController?.isNavigationBarHidden = !hasNavigationBar
        self.hideKeyboardWhenTappedAround()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        if scrollView != nil {
//            self.scrollView.bindScrollToKeyboard()
        }
    }
    
    func configureTopConstraint(value: CGFloat) {
        if #available(iOS 11, *) {
            // safe area constraints already set
        } else {
            print(UIDevice.current.systemVersion.debugDescription)
            if topLayoutConstraint != nil {
                topLayoutConstraint.constant = value
                updateViewConstraints()
            }
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension BaseViewController: BaseViewControllerInterface {
    func showPreloader(isShown: Bool) {
//        if self.preloader == nil {
//            let screenSize = UIScreen.main.bounds
//            let screenWidth = screenSize.width
//            let screenHeight = screenSize.height
//
//            self.preloader = PreloaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
//            self.view.addSubview(preloader!)
//        }
//        if isShown {
//            self.preloader?.show()
//        } else {
//            self.preloader?.hide()
//        }
    }
    
    func showError(title: String, text: String) {
//        if self.errorView == nil {
//            self.errorView = ErrorView(frame: self.view.frame)
//        }
//
//        errorView?.set(title: title, text: text)
//        self.view.addSubview(errorView!)
//        errorView?.delegate = self
    }
    
    func showErrorWithButtons(title: String, text: String) {
        
//        if self.errorView == nil {
//            self.errorView = ErrorView(frame: self.view.frame)
//        }
//
//        errorView?.set(title: title, text: text, hasButtons: true)
//        self.view.addSubview(errorView!)
//        errorView?.delegate = self
    }
}


//extension BaseViewController: ErrorViewDelegate {
//    @objc func errorButtonClicked(hasAccepted: Bool) {
////        errorView?.removeFromSuperview()
//    }
//
//    func closeErroView() {
////        errorView?.removeFromSuperview()
//    }
//}
