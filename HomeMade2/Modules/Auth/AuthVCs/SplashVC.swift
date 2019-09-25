//
//  SplashVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class SplashVC: BaseRegisterVC {
    
    var google : GoogleLoginManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.checkUserNamePassowrd()

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
    
    func checkUserNamePassowrd() {
        if let emailPassword = AppSettings.getEmailPassword(){
            let email = emailPassword.email
            let password = emailPassword.password
            requestToLogin(email: email, password: password)
            
        }
        else{
            checkFacebook()
        }
    }
    func checkFacebook(){
        
        if FBLoginManager.checkFBLogin(){
            FBLoginManager.loginWithFacebook { [weak self] (user, error) in
                if let error = error{
                    print("Facebook Login Error :\(error)")
                    self?.checkGoogle()
                }
                else{
                    guard let socialUser = SocialUser.user(fbUser: user) else{
                        return 
                    }
                    self?.requestToSoicalLogin(socialUser: socialUser, params: ["authMethod": "facebook",
                                                                                "facebookId" : user?.id ?? ""])
                }
            }
        }
        else{
            checkGoogle()
        }
        
        
        
//        if (AccessToken.current != nil) {
//            let graphRequest = GraphRequest.init(graphPath: "me", parameters: ["fields":"first_name,email"])
//            graphRequest.start { (connection, result, error) in
//                if let error = error {
//                    print("Facebook Login Error :\(error)")
//                }
//                else{
//
//                }
//            }
//
//        }
//        else{
//            checkGoogle()
//        }
        
        
        
    }
    func checkGoogle(){
        if GoogleLoginManager.checkGoogleLogin() {
            google = GoogleLoginManager()
            google?.loginWithGoogle { [weak self] (user, error) in
                if let error = error{
                 /*   self?.alertMessage(message: error, completion: {
                        
                    })
                     
 */
                    print("Google login error :\(error)")
                    self?.checkInstaGram()
                }
                else{
                    guard let socialUser = SocialUser.user(googleUser: user!) else{
                        self?.checkInstaGram()
                        return
                    }
                    self?.requestToSoicalLogin(socialUser: socialUser, params: ["authMethod": "google",
                                                                                "googleId" : user?.userID ?? ""])
                }
            }
        }
        else{
            checkInstaGram()
        }
    }
    func checkInstaGram(){
        if false {
            
        }
        else{
            perform(#selector(goToLoginScreen), with: nil, afterDelay: 2)
//            goToLoginScreen()
        }
    }
    
    func goToHomeScreen(){
        
    }
    @objc func goToLoginScreen(){
        
        if AppSettings.isLanguageRemembered() {
            let vc = SelectLoginVC.viewController()
            //        self.navigationItem.hidesBackButton = true
            navigationController?.setViewControllers([vc], animated: true)
        } else {
            let vc = ChangeLanguageVC.viewController()
            vc.rootVC = .Splash
            navigationController?.pushViewController(vc, animated: true)
        }
        

        
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func requestToLogin(email : String, password : String)  {
        
        //        loginBtn.startAnimate(view: self.view)
//        startAnimating()
        
        
        AuthManager().login(email: email, password: password) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error, showAlert: false) ?? false{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                if AppSettings.loggedInUser()?.isEmailVerified ?? false {
                    self?.moveToRootVC()
                }
                else{
                    self?.goToLoginScreen()
                }
            }
            else{
                self?.checkFacebook()
            }
        }
        
//        AuthManager.shared.login(email: email, password: password) { [weak self] (response) in
////            self?.stopAnimating()
//            //            self.loginBtn.stopAnimate(view: self.view)
//
//            switch response {
//
//            case let .sucess(rootModel):
//
//                AppSettings.shared.setLoggedInUser(user: rootModel.data)
//
//                if AppSettings.loggedInUser()?.isEmailVerified ?? false {
//                    self?.moveToRootVC()
//
//                }
//                else{
//                    self?.goToLoginScreen()
//                }
//
//
//
//            case let .failure(error):
//                print("Login Error :\(error)")
//                self?.checkFacebook()
////                nvMessage.showError(body: error)
//            }
//        }
    }
    func  requestToSoicalLogin(socialUser : SocialUser, params : [String : Any])  {
//        startAnimating()
        
        AuthManager().socialLoginCheck(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error, showAlert: false) ?? false{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                
                    self?.moveToRootVC()
                
            }
            else{
                if socialUser.mediaType == .Facebook {
                    FBLoginManager.logout()
                }
                else if socialUser.mediaType == .Google {
                    GoogleLoginManager.logout()
                }
                self?.goToLoginScreen()
            }
        }
    }
        
//        AuthManager.shared.socialLoginCheck(params: params) { [weak self] (result) in
////            self?.stopAnimating()
//
//            switch result {
//            case .sucess(let rootModel):
//                AppSettings.shared.setLoggedInUser(user: rootModel.data)
//                self?.moveToRootVC()
//            case .failure(let error):
//                // nvMessage.showError(body: error)
//                if error.lowercased().contains("no record found") {
//                    self?.goToLoginScreen()
////                    self?.moveToSocialRegister(socialUser: socialUser)
//                }
//                else {
//                    if socialUser.mediaType == .Facebook {
//                        FBLoginManager.logout()
//                    }
//                    else if socialUser.mediaType == .Google {
//                        GoogleLoginManager.logout()
//                    }
//                    nvMessage.showError(title: "Login".localized , body: error)
//                }
//            }
//
//        }
//    }
//    func moveToRootVC() {
//        //set account type
//        let user = AppSettings.shared.loggedInUser
//        let accountType = user?.accountType ?? "Uknown"
//        //        myDefaultAccount = accountType == "seller" ? .supplier : .customer
//
//        if user?.isEmailVerified == true {
//
//            //update userDefaults
//            //            AppSettings.shared.setLoggedInUser(user: LoginResponse)
////            AppSettings.setEmailPassword(email: txt_email.text!, password: txt_password.text!)
//
//            //            AppUserDefault.shared.email = email.text
//            //            AppUserDefault.shared.password = password.text
//            //            AppUserDefault.shared.isUserLoggedIn = true
//
//
//            //socketConnection
//            SocketIOManager.sharedInstance.setupSocket()
//            SocketIOManager.sharedInstance.establishConnection()
//
//            navigationController?.setViewControllers([MenuVC.viewController()], animated: true)
//
//            //            let del = UIApplication.shared.delegate as! AppDelegate
//            //            del.moveToRootMainSectionsVC()
//        }
//        else if user?.isEmailVerified == false {
//            goToLoginScreen()
//            //            myDefaultAccount = .none
//            //            let s = AppConstant.storyBoard.userEntry
//            //            let vc = s.instantiateViewController(withIdentifier: "EmailVerficationVC") as! EmailVerficationVC
//            //            self.navigationController?.pushViewController(vc, animated: true)
//        }
//
//    }
    

}


