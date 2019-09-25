//
//  ForgotPasswordVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit


class ForgotPasswordVC: BaseRegisterVC {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var forgetInfoLabel: UILabel!
    @IBOutlet weak var recoverBtn: UIButton!
    
    static func viewController() -> ForgotPasswordVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBarButton()
        setLocalization()
        email.addleftRightPading()
        self.title = "FORGOT PASSWORD".localized
        
    }
    
    func setLocalization() {
        forgetInfoLabel.text = "Please enter email address to recover your password".localized
        self.recoverBtn.setTitle("RECOVER".localized, for: .normal)
        self.emailLabel.text = "Email".localized
        self.email.placeholder = "e.g jhondoe@gmail.com".localized
        self.setTextFieldDirectionByLanguage(textFields: [email] as! [UITextField])
        
    }
    

    @IBAction func recoverBtnTapped(sender: UIButton) {
    
        self.view.endEditing(true)
        if !formIsVaid() { return }
        
        requestToRecoverPassword()
    }
    
    func formIsVaid() -> Bool {
        
        if  isValid(email: email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: self.title!, body: msg)
            return false
        }
        
        return true
    }
    
    
     //MARK:- web services
    
    func  requestToRecoverPassword()  {
       
//        recoverBtn.startAnimate(view: self.view)
        
        startAnimating()
        AuthManager().forgotPassword(email: email.text!) { [weak self](response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                nvMessage.showSuccess(body: response?.message ?? AppSettings.defaultSuccess, closure: {
                    self?.moveToResetPasswordVC()
                    
                })
            }
        }
       
//        AuthManager.shared.forgotPassword(email: email.text!) { [weak self] (result) in
////            self.recoverBtn.stopAnimate(view: self.view)
//            self?.stopAnimating()
//            switch result {
//
//            case .sucess(let rootModel):
//                
//                nvMessage.showSuccess(body: rootModel.message!, closure: {            
//                    self?.moveToResetPasswordVC()
//
//                })
//            case .failure(let error):
//                nvMessage.showError(title: self?.title! ?? "Alert!", body: error)
//                
//            }
//        }
    }

    
    func moveToResetPasswordVC() {
//        let s = AppConstant.storyBoard.userEntry
        DispatchQueue.main.async {
            let vc = ResetPasswordVC.viewController()
            vc.email = self.email.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
