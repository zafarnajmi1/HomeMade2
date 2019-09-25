//
//  ContactUsVC.swift
//  TailerOnline
//
//  Created by apple on 3/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import DropDown

class ContactUsVC: BaseVC {

    
     //MARK:-  outlets
    @IBOutlet weak var sendBtn: UIButton!
//    @IBOutlet var dropDownBtn: UIButton!
    @IBOutlet weak var helpLabel: UILabel!
    @IBOutlet weak var help: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var lblemailAddress: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var yourCommentsLabel: UILabel!
    @IBOutlet var commentsTv: UITextView!
    var pkr_helpInput: UIPickerView!
    var feedBackTypes = ["App Feed Back".localized,"Complaint".localized]
//    @IBOutlet var commentsTvPlaceHolder: UILabel!
  
    //MARK:- Properties
    
//    let helpDropDown = DropDown()
   
    
     //MARK:-  my life cycle
    static func viewController() -> ContactUsVC{
        
        return UIStoryboard.menuStoryboard.instantiateViewController(withIdentifier: "ContactUsVC") as! ContactUsVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "CONTACT US".localized
        setBackBarButton()
        setLocalization()
        setupHelpDropDown()
        commentsTv.delegate = self
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        
      
       
    }
    
    //MARK:-  Intialization code
    func setLocalization() {
        
        self.sendBtn.setTitle("SEND".localized, for: .normal)
        
        self.firstNameLabel.text = "First Name".localized
        self.lastNameLabel.text = "Last Name".localized
        self.lblemailAddress.text = "Email".localized
        self.yourCommentsLabel.text = "Message".localized
        self.helpLabel.text = "What can we help you with?".localized
        
        self.firstName.placeholder = "e.g Mike".localized
        self.lastName.placeholder = "e.g Tyson".localized
        self.email.placeholder = "e.g miketyson@mail.com".localized
        self.help.placeholder = "App Feedback".localized
        let tfs = [firstName, lastName, email, help] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
        commentsTv.text = "Write your message here".localized
        commentsTv.textColor = UIColor(red: 199, green: 199, blue: 205)
        commentsTv.textContainerInset = UIEdgeInsets(top: 8, left: 20, bottom: 8, right: 20)
//        self.commentsTvPlaceHolder.text = "Write your message here".localized
        let tvs = [commentsTv] as [UITextView]
        
        pkr_helpInput = UIPickerView()
        pkr_helpInput.delegate = self
        pkr_helpInput.dataSource = self
        help.inputView = pkr_helpInput
        help.delegate = self
        
        
        self.setTextViewDirectionByLanguage(textViews: tvs)
        
        self.setViewDirectionByLanguage()
    }
    
    
    
    func setupHelpDropDown(){
//        let ds = ["App Feed Back".localized,"Complaint".localized]
//        helpDropDown.setData(btn: dropDownBtn, dataSource: ds)
//        helpDropDown.selectionAction = {[unowned self](index: Int, item: String) in
//                        self.help.text = item
//                    }
        
    }
    
    //MARK:-  actions
    @IBAction func DropdownAction(_ sender: UIButton) {
//        helpDropDown.show()
    }
    
    
    
    
    func isValidForm()->Bool{
        
        let title = self.title ?? "Contact Us".localized
        
        var stringValue = self.help.text!
        var trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count == 0 {
            let message = "Please select subject".localized
            nvMessage.showError(title: title, body: message)
            
            return false
        }
        stringValue = self.firstName.text!
        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedStr == ""  {
            let msg =  "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        stringValue = self.lastName.text!
        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr == "" {
            let msg =  "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if isValid(email: self.email.text!) == false{
            let message = "Please enter valid email".localized
            nvMessage.showError(title: title, body: message)
            
            return false
        }
        
        stringValue = self.commentsTv.text!
        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if  trimmedStr == "" || trimmedStr == "Write your message here".localized {
            let message = "Please enter valid message".localized
            nvMessage.showError(title: title, body: message)
            
            return false
        }
        return true
        
    }
    
    @IBAction func btnSendAction(_ sender: UIButton) {
        //API Call
        self.view.endEditing(true)
        
        if !isValidForm(){ return }
          requestToContactUs()
        
        
    }
    
    func requestToContactUs()  {

        let fullName = "\(firstName.text!) \(lastName.text!)"
        let params: [String:Any] = ["name":fullName,
                                    "email": self.email.text!,
                                    "subject":self.help.text!,
                                    "message":commentsTv.text! ]

        self.startAnimating()
        
        AuthManager().contactUs(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                nvMessage.showSuccess(body: (response?.message)!, closure: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
        
//        AuthManager().contactUs(params: params) { [weak self] (result) in
//
//           self?.stopAnimating()
//
//            switch result {
//            case .sucess(let rootModel):
//                nvMessage.showSuccess(body: rootModel.message!, closure: {
//                    self?.navigationController?.popViewController(animated: true)
//                })
//            case .failure(let error):
//                nvMessage.showError(body: error)
//            }
//        }

    }
    
}
extension ContactUsVC : UIPickerViewDelegate, UIPickerViewDataSource{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return feedBackTypes.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return feedBackTypes[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        help.text = feedBackTypes[row]
    }
}
extension ContactUsVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
            if textField == help{
                if textField.text == "" {
                    textField.text = feedBackTypes[pkr_helpInput.selectedRow(inComponent: 0)]
                }
            }
        
    }
}
extension ContactUsVC: UITextViewDelegate {
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        if textView.text == "Write your message here".localized{
            textView.text = ""
            textView.textColor = .black
//            textView.font = UIFont(name: "Lato-Regular", size: 16.0)
        }
//        commentsTvPlaceHolder.isHidden = true
        return true
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if commentsTv.text == "" {
            if textView == commentsTv {
                textView.text = "Write your message here".localized
                textView.textColor = UIColor(red: 199, green: 199, blue: 205)
//                textView.font = UIFont(name: "HelveticaNeue", size: 16.0)
                
            }
        }
        
    }
}
