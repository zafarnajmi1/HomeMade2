//
//  EmailVerficationVC.swift
//  TailerOnline
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import SSSpinnerButton

class EmailVerficationVC: BaseRegisterVC {

    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var resendCodeBtn: UIButton!
//    @IBOutlet weak var resendLabel: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var verificationCodeLabel: UILabel!
    @IBOutlet weak var verificationCode: UITextField!
    
    

    
    
    
    var email: String?
    var password : String?
    
    static func viewController() -> EmailVerficationVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "EmailVerficationVC") as! EmailVerficationVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCode.addleftRightPading()
        setBackBarButton()
        self.title = "EMAIL VERIFICATION".localized
//        setLocalization()
    }
    
    func setLocalization()  {
        labelInfo.text = "Please enter 6 digit code sent at your email address to activate account".localized
//        resendLabel.text = "Resend Code".localized
        submitBtn.setTitle("SUBMIT".localized, for: .normal)
        verificationCodeLabel.text = "Enter Verification code *".localized
        setTextFieldDirectionByLanguage(textFields: [verificationCode] as! [UITextField])
        setViewDirectionByLanguage()
    }
    
    
    
//    override func backToMain() {
////        self.popBack(toControllerType: LoginOptionVC.self)
//    }
    
    
     //MARK:- actions
    
    @IBAction func resendCodeBtnTapped(_ sender: UIButton ) {
        
        requestToResendCode()
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton ) {
        
        self.view.endEditing(true)
        if !formIsVaid() {return}
        
        self.requestToEmailVerification()
        
    }

    func formIsVaid() -> Bool {
        
        if verificationCode.text!.count < 3 {
            let msg = "Please Enter valid verification code".localized
            nvMessage.showError(title: self.title!, body: msg )
            return false
        }
       return true
        
    }
   
    func requestToEmailVerification( )  {
//         submitBtn.startAnimate(view: self.view)
        startAnimating()
        AuthManager().verificationCode(code: verificationCode.text!) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                self?.moveToRootVC(email: self?.email, password: self?.password)
            }
        }
        
        
//        AuthManager.shared.verificationCode(code: verificationCode.text!,completion: { [weak self] (result) in
//            self?.stopAnimating()
////            self.submitBtn.stopAnimate(view: self.view)
//
//            switch result {
//
//            case let .sucess(rootModel):
//                AppSettings.shared.setLoggedInUser(user: rootModel.data)
//                self?.moveToRootVC(email: self?.email, password: self?.password)
//
//            case let .failure(error):
//                nvMessage.showError(body: error)
//            }
//
//        })
    }
    
//    func moveToRootVC() {
//        navigationController?.setViewControllers([MenuVC.viewController()], animated: true)
//
//        //set account type
////        let user = AppSettings.shared.loggedInUser
////        let accountType = user?.data?.accountType ?? "Uknown"
//////        myDefaultAccount = accountType == "seller" ? .supplier : .customer
////
////        AppUserDefault.shared.isUserLoggedIn = true
////
////        let app = UIApplication.shared.delegate as! AppDelegate
////        app.moveToRootMainSectionsVC()
//
//    }
    
    
    
    
    func requestToResendCode( )  {
//        showNvLoader()
        startAnimating()
        AuthManager().resendVerificationCode { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
//                AppSettings.shared.setLoggedInUser(user: response.data)
                self?.showError(body: response?.message ?? AppSettings.defaultError)
            }
        }
//        AuthManager.shared.resendVerificationCode { [weak self] (result) in
//            self?.stopAnimating()
//            switch result {
//            case let .sucess(rootModel):
//
//                nvMessage.showError(title: "Alert!".localized, body: rootModel.message ?? "")
////                nvMessage.showSuccess(body: rootModel.message ?? "")
//            case let .failure(error):
//                nvMessage.showError(body: error)
//            }
//        }
    }
    
}


