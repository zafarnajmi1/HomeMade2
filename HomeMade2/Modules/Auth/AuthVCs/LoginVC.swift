//
//  LoginVC.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class LoginVC: BaseRegisterVC {
    
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    
    var rootScreen: AuthRootScreen?
    
    
    
    static func viewController() -> LoginVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        
        // Do any additional setup after loading the view.
    }
    
    override func setupView(){
        txt_email.addleftRightPading()
        txt_password.addleftRightPading()
        setBackBarButton()
        navigationItem.title = "LOGIN"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClick_login(_ sender: Any) {
        self.view.endEditing(true)
        if !formIsValid() {return}
        
        requestToLogin()
    }
    @IBAction func onClick_forgotPassword(_ sender: Any) {
        navigationController?.pushViewController(ForgotPasswordVC.viewController(), animated: true)
//        let storydoard = AppConstant.storyBoard.userEntry
//        let vc = storydoard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func onClick_registerNow(_ sender: Any) {
        if self.rootScreen == .register {
            navigationController?.popViewController(animated: true)
        }
        else{
            let vc = SignupVC.viewController()
            vc.rootScreen = .login
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func formIsValid() -> Bool {
//        let title = "LOGIN".localized
//        
//        if  isValid(email: txt_email.text!) == false {
//            let msg = "Please enter valid email".localized
//            showError(title: title, body: msg)
//            return false
//        }
//        
//        if txt_password.text!.count < 6 || txt_password.text!.count > 32 {
//            let msg = "Please enter valid password, Password must be between 6-32 characters".localized
//            showError(title: title , body: msg)
//            return false
//        }
        return true
    }
    
    
    
    //MARK:-  Web Request
    
    
    func requestToLogin()  {
        
//        loginBtn.startAnimate(view: self.view)
        startAnimating()
        
//        AuthManager1().login(email: txt_email.text!, password: txt_password.text!) { (response, error) in
//            self.stopAnimating()
//        }
//
        AuthManager().login(email: txt_email.text!, password: txt_password.text!) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false {
                AppSettings.shared.setLoggedInUser(user: response?.data)
                self?.moveToRootVC(email: self?.txt_email.text, password: self?.txt_password.text)
            }
        }
        
        
//        AuthManager.shared.login(email: txt_email.text!, password: txt_password.text!) { [weak self] (response) in
//            self?.stopAnimating()
////            self.loginBtn.stopAnimate(view: self.view)
//
//            switch response {
//
//            case let .sucess(rootModel):
//
//
//
//            case let .failure(error):
//                self?.showError(body: error)
//            }
//        }
    }
    
    
//    func moveToRootVC() {
//        //set account type
//        let user = AppSettings.shared.loggedInUser
//        let accountType = user?.accountType ?? "Uknown"
////        myDefaultAccount = accountType == "seller" ? .supplier : .customer
//
//        if user?.isEmailVerified == true {
//
//            //update userDefaults
////            AppSettings.shared.setLoggedInUser(user: LoginResponse)
//            AppSettings.setEmailPassword(email: txt_email.text!, password: txt_password.text!)
//
////            AppUserDefault.shared.email = email.text
////            AppUserDefault.shared.password = password.text
////            AppUserDefault.shared.isUserLoggedIn = true
//
//
//            //socketConnection
//            SocketIOManager.sharedInstance.setupSocket()
//            SocketIOManager.sharedInstance.establishConnection()
//
//            navigationController?.setViewControllers([MenuVC.viewController()], animated: true)
//
////            let del = UIApplication.shared.delegate as! AppDelegate
////            del.moveToRootMainSectionsVC()
//        }
//        else if user?.isEmailVerified == false {
////            myDefaultAccount = .none
////            let s = AppConstant.storyBoard.userEntry
//
//            let vc = EmailVerficationVC.viewController()
//            navigationController?.pushViewController(vc, animated: true)
//        }
//
//    }
    
    
}
