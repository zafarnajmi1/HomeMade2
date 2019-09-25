//
//  ChangePasswordVC.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import SSSpinnerButton

class ChangePasswordVC: BaseRegisterVC {

    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var passwordConfirmLabel: UILabel!
    @IBOutlet weak var newPassword: UITextField!
    @IBOutlet weak var newPasswordLabel: UILabel!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var currentPasswordLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
  
    var email: String?
    static func viewController() -> ChangePasswordVC{
        
        return UIStoryboard.authStoryboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
        self.title = "CHANGE PASSWORD".localized
        self.setLocalization()
        self.setBackBarButton()
        
      
    }
    
    //MARK: - intialization code
    
    func setLocalization() {
        //buttons
        self.submitBtn.setTitle("Submit".localized, for: .normal)
        
        //labels
        self.detailLabel.text = "Enter you new password and then confirm it to change your account password".localized
        self.currentPasswordLabel.text = "Current Password *".localized
        self.newPasswordLabel.text = "New Password *".localized
        self.passwordConfirmLabel.text = "Confirm New Password*".localized
        //textfields
        self.currentPassword.placeholder = "Current Password".localized
        self.newPassword.placeholder = "New Password".localized
        self.passwordConfirm.placeholder = "Confirm New Password".localized
        
        
        let txtFields = [newPassword, passwordConfirm, currentPassword ] as [UITextField]
        //View directions
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        self.setViewDirectionByLanguage()
        
    }
    
     //MARK:-  actions
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {
        
        self.view.endEditing(true)
        if !formIsValid(){return}
        requestToChangePassword()
    }
    
     //MARK:-  form validation
    
    func formIsValid()-> Bool {
        
        let title = (self.title?.localized)!
        
        if currentPassword.text!.count < 6 || currentPassword.text!.count > 32 {
            let msg = "Current password must be between 6-32 characters".localized
            nvMessage.showError(title: title , body: msg)
            return false
        }
        if newPassword.text!.count < 6 || newPassword.text!.count > 32 {
            let msg = "New password must be between 6-32 characters".localized
            nvMessage.showError(title: title , body: msg)
            return false
        }
        if passwordConfirm.text!.count < 6 || passwordConfirm.text!.count > 32 {
            let msg = "Confirm password must be between 6-32 characters".localized
            nvMessage.showError(title: title , body: msg)
            return false
        }
    
        if newPassword.text != passwordConfirm.text {
            let msg = "Confirm new password does not match, please add same new password to confirm".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        
        return true
    }
    
    
    //MARK:-  web services
    
    func requestToChangePassword()  {

        var params = ["currentPassword": currentPassword.text!] as [String: Any]
        params.updateValue(newPassword.text!, forKey: "password")
        params.updateValue(passwordConfirm.text!, forKey: "passwordConfirmation")

//        self.submitBtn.startAnimate(view: self.view)
        startAnimating()
        ProfileManager().changePasswordlogin(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                nvMessage.showSuccess(title: self?.title!, body: response?.message ?? "", closure: {
                    let email = AppSettings.loggedInUser()?.email ?? ""
                    let password = self?.newPassword.text ?? ""
                    AppSettings.setEmailPassword(email: email , password: password)
                    //                    AppUserDefault.shared.password = self.newPassword.text!
                    self?.navigationController?.popViewController(animated: true)
                })

            }
        }
        
        
//        ProfileManager().changePassword(params: params) { [weak self] (result) in
//            self?.stopAnimating()
////            self.submitBtn.stopAnimate(view: self.view)
//
//            switch result {
//            case .sucess(let rootModel):
//
//                nvMessage.showSuccess(title: self?.title!, body: rootModel.message ?? "", closure: {
//                    let email = AppSettings.loggedInUser()?.email ?? ""
//                    let password = self?.newPassword.text ?? ""
//                    AppSettings.setEmailPassword(email: email , password: password)
////                    AppUserDefault.shared.password = self.newPassword.text!
//                    self?.navigationController?.popViewController(animated: true)
//                })
//            case .failure(let error):
//                nvMessage.showError(title: self?.title! ?? "", body: error)
//            }
//        }
    }
    
    
  
    
}
