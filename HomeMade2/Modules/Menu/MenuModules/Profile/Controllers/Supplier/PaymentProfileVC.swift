//
//  PaymentProfileVC.swift
//  TailerOnline
//
//  Created by apple on 3/6/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

class PaymentProfileVC: BaseVC {

     //MARK:- outlets
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var clientId: UITextField!
    @IBOutlet weak var secretId: UITextField!
    //labels for localization
    @IBOutlet weak var secretIdLabel: UILabel!
    @IBOutlet weak var enterIdLabel: UILabel!
    @IBOutlet weak var paymentLabelInfo: UILabel!
    
     //MARK:-  my life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackBarButton()
        self.title = "Payment Profile".localized
        setLocalization()
        
        let user = AppSettings.shared.loggedInUser
        secretId.text = user?.paypalSecretId
        clientId.text = user?.paypalClientId
        
    }
    
     //MARK:- base configuration
    
    func setLocalization()  {
        self.paymentLabelInfo.text = "Save your payment profile".localized
        self.enterIdLabel.text = "Enter Id".localized
        self.secretIdLabel.text = "Secret".localized
        self.saveBtn.setTitle("Save".localized, for: .normal)
        
        self.clientId.placeholder = "Enter Id".localized
        self.secretId.placeholder = "Secret".localized
        
        let tfs = [clientId, secretId] as [UITextField]
        setTextFieldDirectionByLanguage(textFields: tfs)
    }
    
   //MARK:-  form validtion
   
    func formIsValid()-> Bool{
        
        if (self.clientId.text?.count)! < 3 {
            
            let msg = "Please enter valid PayPal Client ID ".localized
            nvMessage.showError(title: self.title!.localized, body: msg )
            return false
        }
        else  if(self.secretId.text?.count)! < 3 {
            
            let msg = "Please enter valid PayPal Secret ID ".localized
            nvMessage.showError(title: self.title!.localized, body: msg )
            
            return false
        }
        return true
    }
    
     //MARK:- actions
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if formIsValid(){
           self.requestToUpdateCredetials()
        }
        
    }
    
    
    func requestToUpdateCredetials()  {
        let params = ["clientId": clientId.text!,
                      "secretId": secretId.text!] as [String: Any]
       
//        saveBtn.startAnimate(view: self.view)
        startAnimating()
        ProfileManager.shared.updateStorePaypalCredentials(params: params) { [weak self] (result) in
//            self.saveBtn.stopAnimate(view: self.view)
            self?.stopAnimating()
            
            switch result {
            case .sucess(let root):
                AppSettings.shared.setLoggedInUser(user: root.data)
                nvMessage.showSuccess(title: self?.title, body: root.message ?? "", closure: {
                    self?.navigationController?.popViewController(animated: true)
                })
            case .failure(let error):
                nvMessage.showError(body: error)
            }
        }
    }
    
}
