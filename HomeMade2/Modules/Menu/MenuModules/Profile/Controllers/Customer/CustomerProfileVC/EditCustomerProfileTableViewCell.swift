//
//  EditCustomerProfileTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import DLRadioButton
//import SSSpinnerButton
import CoreLocation
import ObjectMapper

class EditCustomerProfileTableViewCell: BaseProfileTableViewCell {

    //MARK:- outlets
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var maleBtn: UIButton! //male
    @IBOutlet weak var femaleBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var attachBtn: LoaderButton!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
  
    
    
    //labels for localization
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    var imagePath: String?
    var newImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.email.isEnabled = false
        self.maleBtn.isSelected = true //default male selected
        self.setLocalization()
        self.address.delegate = self
        self.imagePickerDelegate = self
        
        self.imagePath = nil
     
    }
    
    
    //MARK: - Base config
    
    fileprivate func setLocalization() {
       
        //Buttons
        self.femaleBtn.setTitle("Female".localized, for: .normal)
        self.maleBtn.setTitle("Male".localized, for: .normal)
        self.saveBtn.setTitle("Save".localized, for: .normal)
        //Labels
        self.genderLabel.text = "Gender".localized
      
        self.firstNameLabel.text = "First Name".localized
        self.lastNameLabel.text = "Last Name".localized
        self.emailLabel.text = "Email".localized
        self.phoneLabel.text = "Phone Number".localized
        self.addressLabel.text = "Address".localized
   
        //TF
        self.firstName.placeholder = "e.g Jhon".localized
        self.lastName.placeholder = "e.g Doe".localized
        self.email.placeholder = "e.g Jhondoe@gmail.com".localized
        self.phone.placeholder = "+00000000".localized
        self.address.placeholder = "e.g 46 street, Al Ain. UAE".localized
       
        
        let txtFields = [firstName, lastName, email, phone, address] as [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: txtFields)
        
        let tfs = [firstName, lastName, email, phone, address] as! [UITextField]
        self.setTextFieldDirectionByLanguage(textFields: tfs)
        self.sharedVC?.setViewDirectionByLanguage()
        
    }
    
    //MARK:- data initalazation
    func setData(model: LoginAPIResponse)  {
        guard let user = model.data else {return}
        
        myImage.kf.setImage(with: URL(string: user.image ?? ""), placeholder: PlaceHolder.user)
        
       

        firstName.text = user.firstName
        lastName.text = user.lastName
        email.text = user.email
        phone.text = user.phone
        address.text = user.address
        let lat = user.location?.first
        let long = user.location?.last
        self.location = CLLocationCoordinate2D(latitude:lat!, longitude: long!)
        
        
        
        if let gender = user.gender {
            if gender == "male" {
                maleBtn.isSelected = true
            } else {
                femaleBtn.isSelected = true
            }
        }
        
    }
    
    
    
    //MARK: - form validation
    private func  formIsvalid() -> Bool {
        
        let title = "Customer".localized
        
        var stringValue = self.firstName.text!
        var trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count < 2 {
            let msg = "Please enter valid first name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        stringValue = self.lastName.text!
        trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr.count < 2 {
            let msg = "Please enter valid last name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  isValid(email: email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  phone.text!.count < 9 || phone.text!.count > 15{
            let msg = "Phone number must be between 9-15 characters".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (address.text?.count)! < 2 {
            let msg = "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        return true
    }
    
    
    //MARK:- actions
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
        
//        self.sharedVC?.view.endEditing(true)
//        if !formIsvalid() { return }
//           requestToUpdateProfile()
       
    }

    
  
    
     //MARK:-  web services
    
//    func requestToUpdateProfile() {
//        let gender = maleBtn.isSelected == true ? "male": "female"
//        let locale = myDefaultLanguage == .en ? "en":"ar"
//        var params = ["firstName": firstName.text!] as [String: Any]
//        params.updateValue(lastName.text!, forKey: "lastName")
//        params.updateValue(phone.text!, forKey: "phone")
//        params.updateValue(gender, forKey: "gender")
//        params.updateValue(address.text!, forKey: "address")
//        params.updateValue(location!.latitude, forKey: "latitude")
//        params.updateValue(location!.longitude, forKey: "longitude")
//        params.updateValue(locale, forKey: "locale")
//
//        if let path = imagePath {
//            params.updateValue(path, forKey: "image")
//        }
//
//
//        saveBtn.startAnimate(view: self.contentView)
//        ProfileManager.shared.editProfile(params: params) { (result) in
//            self.saveBtn.stopAnimate(view: self.contentView)
//            self.imagePath = nil
//
//            switch result {
//            case .sucess(let root):
//                AppSettings.shared.setLoggedInUser(user: root)
//                if let image = self.newImage {
//                    self.myImage.setPath(image: root.data?.image, placeHolder: image)
//                }
//                nvMessage.showSuccess(title: "Edit Profile".localized, body: root.message ?? "", closure: {
//                    self.sharedVC?.navigationController?.popViewController(animated: true)
//                })
//
//            case .failure(let error):
//                nvMessage.showError(body: error)
//
//            }
//        }
//
//    }
    
    
    
    
}

extension EditCustomerProfileTableViewCell: BaseImagePickerTableViewCellDelegate {
   
    func mySelectedImage(image: UIImage) {
        
        self.myImage.image = image
        self.newImage = image
        
        self.attachBtn.showLoading(view: contentView )
        self.progressLabel.isHidden = false
        SocketEventManager.shared.uploadImage(image: image) { (result) in
            
            switch result {
            case .failure(let error):
                break
            case .progress(let value):
                  self.progressLabel.text = "\(Int(value))%"
            case .path(let fileName):
                  self.progressLabel.isHidden = true
                self.attachBtn.hideLoading(view: self.contentView)
                self.imagePath = fileName
               
//                self.requestToUpdateProfile()
            }
            
        }
        
    }
 
}




