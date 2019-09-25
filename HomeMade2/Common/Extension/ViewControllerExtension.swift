//
//  WindowExtension.swift
//  Delivigo
//
//  Created by Muhammad Naveed on 9/8/18.
//  Copyright © 2018 Muhammad Naveed. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    func switchRootViewController(_ viewController: UIViewController,  animated: Bool = true, duration: TimeInterval = 0.5, options: UIView.AnimationOptions = .transitionCrossDissolve, completion: (() -> Void)? = nil) {
        
        guard animated else {
            rootViewController = viewController
            return
        }
        
        UIView.transition(with: self, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            self.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }) { _ in
            completion?()
        }
    }
}

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }

}



extension UIViewController {
    func confirmationAlert(title: String = "Please Confirm".localized, message: String, completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let options = ["NO".localized, "YES".localized]
        
        for (index, option) in options.enumerated() {
            if index == 0 {
                alertController.addAction(UIAlertAction.init(title: option, style: .cancel, handler: { (action) in
                    completion(index)
                }))
            }
            else {
                alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                    completion(index)
                }))
            }
            
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    func alertMessage(title: String = "Heads-up!".localized, message: String, btnTitle: String = "Try Again".localized, completion: @escaping () -> Void) {
       
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       
        
        alertController.addAction(UIAlertAction.init(title: btnTitle, style: .default, handler: { (action) in
            completion()
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}


extension  UIViewController {
    
    /// pop back to specific viewcontroller
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
    static func topVC() -> UIViewController?{
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        if let rootVC = rootVC as? UINavigationController{
            return rootVC.topViewController
        }
        else if let tabVC = rootVC as? UITabBarController{
            if let selectedNav = tabVC.selectedViewController as? UINavigationController{
                return selectedNav.topViewController
            }
            else{
                return tabVC.selectedViewController
            }
        }
        else{
            return rootVC
        }
            //do something if it's an instance of that class
//            if let tabVC = rootNav.topViewController as? UITabBarController{
//
//            }
//            else{
//                return rootNav.topViewController
//            }
//        }
//        else{
//            return rootNav
//        }
    }
    
//    static func viewController(storyBoard : UIStoryboard? = nil) -> UIViewController
//    {
//        return storyBoard?.instantiateViewController(withIdentifier: self.className) ?? UIViewController()
//        
//    }
}

