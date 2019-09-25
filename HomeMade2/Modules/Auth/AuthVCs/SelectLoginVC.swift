//
//  SelectLoginVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn

enum AuthRootScreen {
    case selectLogin
    case login
    case register
}

class SelectLoginVC: BaseRegisterVC {
    var google : GoogleLoginManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()

        // Do any additional setup after loading the view.
    }
    override func setupView() {
//        setBackBarButton()
        hideBackButton()
        navigationItem.title = "LOGIN OR CREATE ACCOUNT"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    static func viewController() -> SelectLoginVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "SelectLoginVC") as! SelectLoginVC
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions

    
    @IBAction func onClick_facebook(_ sender: Any) {
        
        FBLoginManager.logout()
        
        FBLoginManager.loginWithFacebook { [weak self] (fbuser, error) in
            if let error = error{
                self?.alertMessage(message: error, completion: {
                    
                })
                print("Facebook login Error :\(error)")
            }
            else{
                print("Facebook Login successful")
//                let socialUser = SocialUser.user(fbUser: fbuser)
                guard let socialUser = SocialUser.user(fbUser: fbuser) else{
                    return
                }
                
                self?.requestToSoicalLogin(socialUser : socialUser, params: ["authMethod": "facebook",
                                                    "facebookId" : fbuser?.id ?? ""])
            }
            
        }
        
        
        
        
    }
    
    @IBAction func onClick_google(_ sender: Any) {
        
        
        GIDSignIn.sharedInstance()?.signOut()
        
        google = GoogleLoginManager()//
        google!.loginWithGoogle { [weak self] (user, error) in
            
            if let error = error{
                self?.alertMessage(message: error, completion: {
                    
                })
            }
            else{
                guard let socialUser = SocialUser.user(googleUser: user!) else{
                    return
                }
                self?.requestToSoicalLogin(socialUser: socialUser, params: ["authMethod": "google",
                                                    "googleId" : user?.userID ?? ""])
            }
            
            print("User Name :\(String(describing: user))")
//            if let token = AppUserDefault.shared.fcmToken {
//                params.updateValue(token, forKey: "fcm")
//            }
            
            
            
            
        }
        
        
    }
    

    @IBAction func onClick_instagram(_ sender: Any) {
        
    }
    @IBAction func onClick_login(_ sender: Any) {
        let vc = LoginVC.viewController()
        vc.rootScreen = .selectLogin
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClick_guest(_ sender: Any) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.moveToRootMainVC()
        
//        let tabbar = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "zxc") as! UITabBarController
//        navigationController?.pushViewController(tabbar, animated: true)

//        navigationController?.setViewControllers([BaseTabbarVC.viewController()], animated: true)
    }
    @IBAction func onClick_register(_ sender: Any) {
        let vc = SignupVC.viewController()
        vc.rootScreen = .selectLogin
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SelectLoginVC {
    func  requestToSoicalLogin(socialUser : SocialUser, params : [String : Any])  {
        startAnimating()
        
        AuthManager().socialLoginCheck(params: params) { [weak self] (response, error) in
            self?.stopAnimating()
            if let error = error {
                self?.showError(body: error)
            }
            guard let response = response else{
                return
            }
            if response.message?.lowercased().contains("no record found") ?? false {
                self?.moveToSocialRegister(socialUser: socialUser)
            }
            else{
                if socialUser.mediaType == .Facebook {
                    FBLoginManager.logout()
                }
                else if socialUser.mediaType == .Google {
                    GoogleLoginManager.logout()
                }
                self?.showError(title: "Login".localized , body: response.message ?? AppSettings.defaultError)
            }

//            if self?.checkResponse(response: response, error: error, showAlert: false) ?? false{
//                AppSettings.shared.setLoggedInUser(user: response?.data)
//
//                self?.moveToRootVC()
//
//            }
//            else{
//                guard let response = response else{
//                    return
//                }
//                if response?.message.lowercased().contains("no record found") ?? false {
//                    self?.moveToSocialRegister(socialUser: socialUser)
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
//
//            }
        }
        
//        AuthManager.shared.socialLoginCheck(params: params) { [weak self] (result) in
//            self?.stopAnimating()
//
//            switch result {
//            case .sucess(let rootModel):
//                AppSettings.shared.setLoggedInUser(user: rootModel.data)
//                self?.moveToRootVC()
//            case .failure(let error):
//                // nvMessage.showError(body: error)
//                if error.lowercased().contains("no record found") {
//                    self?.moveToSocialRegister(socialUser: socialUser)
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
    }
//    func moveToRootVC() {
//        //set account type
//        let user = AppSettings.shared.loggedInUser
//        if user?.isEmailVerified == true {
//
//            AppUserDefault.shared.isUserLoggedInBySocialAccount = true
////
//            AppUserDefault.shared.isUserLoggedIn = false
//
//            SocketIOManager.sharedInstance.setupSocket()
//            SocketIOManager.sharedInstance.establishConnection()
//
//
////            navigationController?.setViewControllers([BaseTabbarVC.viewController()], animated: true)
//
//        }
//        else if user?.isEmailVerified == false {
//            let vc = EmailVerficationVC.viewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//
//    }
    func moveToSocialRegister(socialUser : SocialUser) {
//        let authMethod = socialAccountTypeSelected.rawValue
//        let model = SocialProfileModel(firstName: self.firstName,
//                                       lastName: self.lastName,
//                                       email: self.email,
//                                       socialId: self.socialId,
//                                       socialToken: self.socialToken,
//                                       authMethod: authMethod)
        
        
        let vc = RegisterSocialVC.viewController()
        vc.profileModel = socialUser
        
//        let board = UIStoryboard(name: "UserEntry", bundle: nil)
//        let vc = board.instantiateViewController(withIdentifier: "RegisterSocialVC") as! RegisterSocialVC
//        vc.profileModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
