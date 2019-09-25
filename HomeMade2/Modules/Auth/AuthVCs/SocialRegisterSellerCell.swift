//
//  SocialRegisterSellerCell.swift
//  HomeMade2
//
//  Created by Apple on 24/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SocialRegisterSellerCell: SocialRegisterBaseCell {
    @IBOutlet weak var txt_storeName: UITextField!
    @IBOutlet weak var lbl_storeName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        txt_storeName.addleftRightPading()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func setData(model: SocialUser) {
        profileModel = model
        txt_email.text = model.Email
    }
    @IBAction func onClick_signup(_ sender: Any) {
        self.sharedVC?.view.endEditing(true)
        if !self.formIsvalid() {return}
        
        reuquestToCreateUserAcount()
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
        
        return true
    }
    
    
    
    private func reuquestToCreateUserAcount()  {
        
        //        let gender = maleBtn.isSelected == true ? "male" : "female"
        
        let params = [
            "storeName":txt_storeName.text!,
            "phone":txt_phoneNumber.text!,
            "email":txt_email.text!,
            "accountType": "seller",
            "address": txt_address.text!,
            "latitude": location!.latitude,
            "longitude": location!.longitude,
            "accessToken":profileModel.accessToken!,
            "authMethod":profileModel.authMethod,
            "socialId":profileModel._id!] as  [String:Any]
        
        self.sharedVC?.showNvLoader()
        AuthManager().socialLoginRegister(params: params) { [weak self] (response, error) in
            self?.sharedVC?.stopAnimating()
            if let error = error {
                nvMessage.showError(title: "Supplier".localized,body: error)
            }
            else if response?.success == false{
                nvMessage.showError(title: "Supplier".localized,body: response?.message ?? AppSettings.defaultError)
            }
            else{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                self?.moveToRootVC()
            }
            
            //            switch result {
            //            case let .sucess(model):
            //
            //            case let .failure(error):
            //                print("Request Failed With Error: \(error)")
            //                nvMessage.showError(title: "Supplier".localized, body: error)
            //            }
        }
//        AuthManager.shared.socialLoginRegister(params: params) { (result) in
//            
//            self.sharedVC?.hideNvloader()
//            switch result {
//            case .sucess(let rootModel):
//                AppSettings.shared.setLoggedInUser(user: rootModel.data)
//                self.moveToRootVC()
//            case .failure(let error):
//                nvMessage.showError(body: error)
//            }
//            
//        }
    }
    
    func moveToRootVC() {
        //set account type
        let user = AppSettings.shared.loggedInUser
        let accountType = user?.accountType ?? "Uknown"
        //        myDefaultAccount = accountType == "seller" ? .supplier : .customer
        
        if user?.isEmailVerified == true {
            
            //update userDefaults
            //            AppUserDefault.shared.socialId = profileModel.socialId
            //            AppUserDefault.shared.authMethod = profileModel.authMethod
            AppUserDefault.shared.isUserLoggedInBySocialAccount = true
            AppUserDefault.shared.isUserLoggedIn = false
            AppUserDefault.shared.email = nil
            AppUserDefault.shared.password = nil
            
            //socketConnection
            SocketIOManager.sharedInstance.setupSocket()
            SocketIOManager.sharedInstance.establishConnection()
            
            sharedVC?.navigationController?.setViewControllers([MenuVC.viewController()], animated: true)
            
            
            
//            sharedVC?.navigationController?.pushViewController(MenuVC.viewController(), animated: true)
            
            
            //            let del = UIApplication.shared.delegate as! AppDelegate
            //            del.moveToRootMainSectionsVC()
        }
        else if user?.isEmailVerified == false {
            
            let vc = EmailVerficationVC.viewController()
            //            vc.email = self.txt_email.text
            let nvc = self.sharedVC?.navigationController
            nvc?.pushViewController(vc, animated: true)
            
            //            let s = AppConstant.storyBoard.userEntry
            //            let vc = s.instantiateViewController(withIdentifier: "EmailVerficationVC") as! EmailVerficationVC
            //            self.sharedVC?.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}
