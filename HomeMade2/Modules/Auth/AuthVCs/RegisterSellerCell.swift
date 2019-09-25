//
//  RegisterSellerCell.swift
//  HomeMade2
//
//  Created by Apple on 23/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class RegisterSellerCell: RegisterBaseCell {
    @IBOutlet weak var txt_storeName: UITextField!
    @IBOutlet weak var lbl_storeName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        txt_storeName.addleftRightPading()
        txt_email.addleftRightPading()
        txt_phoneNumber.addleftRightPading()
        txt_address.addleftRightPading()
        txt_password.addleftRightPading()
        txt_confirmPassowrd.addleftRightPading()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onClick_signup(_ sender: Any) {
        self.sharedVC?.view.endEditing(true)
        if !formIsvalid() {return}
        
        self.reuquestToSignup()
    }
    private func reuquestToSignup()  {
        
        let params = [
            "storeName":txt_storeName.text!,
            "phone":txt_phoneNumber.text!,
            "email":txt_email.text!,
            "password":txt_password.text!,
            "passwordConfirmation":txt_confirmPassowrd.text!,
            "accountType": "seller",
            "address": txt_address.text!,
            "latitude": location!.latitude,
            "longitude": location!.longitude] as  [String:Any]
        
//        registerBtn.startAnimate(view: self.contentView)
        sharedVC?.startAnimating()
        AuthManager().register(params: params) { [weak self] (response, error) in
            self?.sharedVC?.stopAnimating()
            if let error = error {
                    nvMessage.showError(title: "Supplier".localized,body: error)
            }
            else if response?.success == false{
                nvMessage.showError(title: "Supplier".localized,body: response?.message ?? AppSettings.defaultError)
            }
            else{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                self?.moveToEmailVerifaicaton()
            }

//            switch result {
//            case let .sucess(model):
//
//            case let .failure(error):
//                print("Request Failed With Error: \(error)")
//                nvMessage.showError(title: "Supplier".localized, body: error)
//            }
        }
        
//        AuthManager.shared.register(params: params) { [weak self] (result) in
//            self?.sharedVC?.stopAnimating()
////            self.registerBtn.stopAnimate(view: self.contentView)
//
//            switch result {
//            case let .sucess(model):
//                AppSettings.shared.setLoggedInUser(user: model.data)
//                self?.moveToEmailVerifaicaton()
//            case let .failure(error):
//                print("Request Failed With Error: \(error)")
//                nvMessage.showError(title: "Supplier".localized, body: error)
//            }
//        }
    }
    func moveToEmailVerifaicaton()  {
        //        let s = AppConstant.storyBoard.userEntry
        let vc = EmailVerficationVC.viewController()
        vc.email = self.txt_email.text
        let nvc = self.sharedVC?.navigationController
        nvc?.pushViewController(vc, animated: true)
    }
    private func  formIsvalid() -> Bool {
        
        let title = "Supplier".localized
        
        let stringValue = self.txt_storeName.text!
        let trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count < 2 {
            let msg = "Please enter valid Store name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
//        stringValue = self.txt_lastName.text!
//        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
//        if trimmedStr.count < 2 {
//            let msg = "Please enter valid last name".localized
//            nvMessage.showError(title: title, body: msg)
//            return false
//        }
        if  isValid(email: txt_email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  txt_phoneNumber.text!.count < 9 || txt_phoneNumber.text!.count > 15{
            let msg = "Phone number must be between 9-15 characters".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (txt_address.text?.count)! < 2 {
            let msg = "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if txt_password.text!.count < 6 || txt_password.text!.count > 32 {
            let msg = "Password must be between 6-32 characters".localized
            nvMessage.showError(title: title , body: msg)
            return false
        }
        //        if txt_confirmPassowrd.text!.count < 6 || txt_confirmPassowrd.text!.count > 32 {
        //            let msg = "Confirm password must be between 6-32 characters".localized
        //            nvMessage.showError(title: title , body: msg)
        //            return false
        //        }
        if txt_password.text != txt_confirmPassowrd.text {
            let msg = "Confirm Password does not match, please add same password to confirm".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        
        return true
    }

}
