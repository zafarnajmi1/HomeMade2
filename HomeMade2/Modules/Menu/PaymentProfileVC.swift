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
    static func viewController() -> PaymentProfileVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "PaymentProfileVC") as! PaymentProfileVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        
        
    }
    
     //MARK:- base configuration
    override func setupView() {
        setLocalization()
        self.title = "Payment Profile".localized
        setBackBarButton()
        let user = AppSettings.loggedInUser()
        clientId.addleftRightPading()
        secretId.addleftRightPading()
        secretId.text = user?.paypalSecretId
        clientId.text = user?.paypalClientId
    }
    func setLocalization()  {
        self.paymentLabelInfo.text = "Save your payment profile".localized
        self.enterIdLabel.text = "Client Id *".localized
        self.secretIdLabel.text = "Secret *".localized
        self.saveBtn.setTitle("Save".localized, for: .normal)
        
        self.clientId.placeholder = "Enter Id".localized
        self.secretId.placeholder = "Secret".localized
        
        let tfs = [clientId, secretId] as [UITextField]
        setTextFieldDirectionByLanguage(textFields: tfs)
    }
    
   //MARK:-  form validtion
   
    func formIsValid()-> Bool{
        
        if self.clientId.text?.isEmpty ?? false {
            
            let msg = "Please enter valid PayPal Client ID ".localized
            showError(title: self.title!.localized, body: msg )
            return false
        }
        else if self.secretId.text?.isEmpty ?? false {
            
            let msg = "Please enter valid PayPal Secret ID ".localized
            showError(title: self.title!.localized, body: msg )
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
       
        startAnimating()
        
        ProfileManager().updateStorePaypalCredentials(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                
                AppSettings.shared.setLoggedInUser(user: response?.data)
                
                nvMessage.showSuccess(body: response?.message ?? "IDs updated successfully".localized, closure: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
        
//        ProfileManager().updateStorePaypalCredentials(params: <#T##[String : Any]#>, completionHandler: <#T##(LoginAPIResponse?, String?) -> Void#>)(params: params) { (result) in
//            self.stopAnimating()
//            switch result {
//            case .sucess(let root):
//                AppSettings.shared.setUser(model: root.user!)
//                nvMessage.showSuccess(title: self.title!, body: root.message ?? "", closure: {
//                    self.navigationController?.popViewController(animated: true)
//                })
//            case .failure(let error):
//                nvMessage.showError(body: error)
//            }
//        }
    }
    
}
