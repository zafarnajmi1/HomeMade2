//
//  BaseRegisterVC.swift
//  HomeMade2
//
//  Created by Apple on 29/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class BaseRegisterVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func moveToRootVC(email : String? = nil, password : String? = nil) {
        
        let user = AppSettings.shared.loggedInUser
        if user?.isEmailVerified == true {
            
            if let email = email, let password = password {
                AppSettings.setEmailPassword(email: email, password: password)
            }
            SocketIOManager.sharedInstance.setupSocket()
            SocketIOManager.sharedInstance.establishConnection()
            requestToLoadSetting()
        }
        else if user?.isEmailVerified == false {
            let vc = EmailVerficationVC.viewController()
            vc.email = email
            vc.password = password
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        else {
            
        }
        
    }
    func requestToLoadSetting()  {
        
        
        if !(self is SplashVC){
            startAnimating()
        }
        
        SettingManger().fetchSettings { [weak self] (response, error) in
            self?.stopAnimating()
            if  error != nil || !(response?.success ?? false){
                print("Failed To Fetch the settings.")
                self?.requestToLoadSetting()
            }
            else{
                AppSettings.shared.setSettings(model: response?.data)
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.moveToRootMainVC()
                
//                else{
//                    self?.alertMessage(message: response?.message ?? "Unknown Error".localized, completion: {
//
//                    })
//                }
            }
        }
        
//        SettingManger.shared.fetchSettings { [weak self] (response) in
//            self?.stopAnimating()
//            switch response {
//
//            case let .sucess(rootModel):
//                AppSettings.shared.setSettings(model: rootModel.data)
//
//
//
////                let tabbar = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
////
////
////                self?.navigationController?.setViewControllers([tabbar], animated: true)
////                self?.navigationController?.pushViewController(tabbar, animated: true)
//
//
////                self?.navigationController?.setViewControllers([BaseTabbarVC.viewController()], animated: true)
////                self.requestToLogin() // API Call
//            case let .failure(error):
//                self?.alertMessage(message: error, completion: {
//                    self?.requestToLoadSetting()
//                })
//            }
//        }
    }
    

}
