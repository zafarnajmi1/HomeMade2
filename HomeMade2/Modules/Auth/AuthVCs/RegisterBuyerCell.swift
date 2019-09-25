//
//  RegisterBuyerCell.swift
//  HomeMade2
//
//  Created by Apple on 23/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class RegisterBuyerCell: RegisterBaseCell {
    
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var lbl_lastName: UILabel!

    @IBOutlet weak var btn_male: UIButton!
    @IBOutlet weak var btn_female: UIButton!
    
    var gender = "male"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txt_firstName.addleftRightPading()
        txt_lastName.addleftRightPading()
        txt_email.addleftRightPading()
        txt_phoneNumber.addleftRightPading()
        txt_address.addleftRightPading()
        txt_password.addleftRightPading()
        txt_confirmPassowrd.addleftRightPading()
        
        
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func onClick_male(_ sender: Any) {
       
        btn_male.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
        btn_female.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
        gender = "male"
        
    }
    @IBAction func onClick_female(_ sender: Any) {
        btn_male.setImage(#imageLiteral(resourceName: "radiobutton_unsl"), for: .normal)
        btn_female.setImage(#imageLiteral(resourceName: "radiobutton_sl"), for: .normal)
        gender = "female"
        
    }
    @IBAction func onClick_signup(_ sender: Any) {
        self.sharedVC?.view.endEditing(true)
        if !self.formIsvalid() {return}
        
        self.reuquestToSignup()
    }
    func reuquestToSignup()  {
//        let gender = maleBtn.isSelected == true ? "male" : "female"
        
        let params = [
            "firstName":txt_firstName.text!,
            "lastName": txt_lastName.text!,
            "phone":txt_phoneNumber.text!,
            "email":txt_email.text!,
            "password":txt_password.text!,
            "passwordConfirmation":txt_confirmPassowrd.text!,
            "accountType": "buyer",
            "address": txt_address.text!,
            "latitude": location!.latitude,
            "longitude": location!.longitude,
            "gender": gender] as  [String:Any]
        
//        registerBtn.startAnimate(view: self.contentView)
        sharedVC?.startAnimating()
        AuthManager().register(params: params) { [weak self] (response, error) in
            self?.sharedVC?.stopAnimating()
            if let error = error {
                nvMessage.showError(title: "Customer".localized,body: error)
            }
            else if response?.success == false{
                nvMessage.showError(title: "Customer".localized, body: response?.message ?? AppSettings.defaultError)
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
//
//            case let .sucess(model):
//                AppSettings.shared.setLoggedInUser(user: model.data)
//                self?.moveToEmailVerifaicaton()
//            case let .failure(error):
//                nvMessage.showError(title: "Customer".localized, body: error)
//            }
//        }
    }
    func moveToEmailVerifaicaton()  {
//        let s = AppConstant.storyBoard.userEntry
        let vc = EmailVerficationVC.viewController()
        vc.email = self.txt_email.text
        vc.password = self.txt_password.text
        let nvc = self.sharedVC?.navigationController
        nvc?.pushViewController(vc, animated: true)
    }
    private func  formIsvalid() -> Bool {
        
        let title = "Customer".localized
        
        var stringValue = self.txt_firstName.text!
        var trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count < 2 {
            let msg = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        stringValue = self.txt_lastName.text!
        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count < 2 {
            let msg = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
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
