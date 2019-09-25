//
//  BaseNavVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseNavVC: UINavigationController {
    
    
    static func viewController(root : UIViewController) -> BaseNavVC{
        
        let vc = BaseNavVC.init(rootViewController: root)
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor(red: 33.0/255.0, green: 35.0/255.0, blue: 45.0/255.0, alpha: 1)
//        navigationBar.titleTextAttributes
        navigationBar.titleTextAttributes = [.font : UIFont.boldSystemFont(ofSize: 22), .foregroundColor : UIColor.white]

        // Do any additional setup after loading the view.
    }
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: true)
//        pushViewController(viewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    static func currentNav() -> BaseNavVC{
        
        if let tabVC = UIApplication.shared.keyWindow?.rootViewController as? TabbarVC{
            let vc = tabVC.selectedViewController as! BaseNavVC
            return vc
        }
        
        if let navVC = UIApplication.shared.keyWindow?.rootViewController as? BaseNavVC{
            return navVC
        }
        else{
            return BaseNavVC()
        }
        
        
        
        
        
//        let vc = BaseNavVC.init(rootViewController: root)
//        return vc
    }

}
