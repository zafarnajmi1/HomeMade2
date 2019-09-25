//
//  EditStoreProfileTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
//import SSSpinnerButton
import CoreLocation

class EditStoreProfileTableViewCell: BaseProfileTableViewCell {

    //MARK:- outlets
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var storeNameEnLabel: UILabel!
    @IBOutlet weak var storeNameArLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var descEnLabel: UILabel!
    @IBOutlet weak var descArLabel: UILabel!
    //textfields
    @IBOutlet weak var storeNameEn: UITextField!
    @IBOutlet weak var storeNameAr: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var descEn: UITextView!
    @IBOutlet weak var descAr:UITextView!
    
    @IBOutlet weak var attachBtn: LoaderButton!
   
    var imagePath: String?
    var newImage: UIImage?
    
     //MARK:- my life cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLocalization()
        self.address.delegate = self
        self.email.isEnabled = false
        self.imagePickerDelegate  = self
    }
    
    
    func setLocalization()  {
        saveBtn.setTitle("Save".localized, for: .normal)
        
        addressLabel.text = "Address".localized
        emailLabel.text = "Enter Your Email".localized
        phoneLabel.text = "Phone Number".localized
      //  descEnLabel.text = "Description".localized
        
        address.placeholder = "Address".localized
        email.placeholder = "Enter Your Email".localized
        phone.placeholder = "Phone Number".localized
        
        
        let ts = [storeNameEn, address, email, phone]
        setTextFieldDirectionByLanguage(textFields: ts as! [UITextField])
        
    }

    //MARK:- data initalazation
    func setData(model: LoginResponse)  {
        guard let user = model.data else {return}
        
//        myImage.setPath(image: user.image,
//                        placeHolder: AppConstant.placeHolders.user)
        
        storeNameEn.text = user.storeNameEn
        storeNameAr.text = user.storeNameAr
        email.text = user.email
        phone.text = user.phone
        address.text = user.address
        let lat = user.location?.first
        let long = user.location?.last
        self.location = CLLocationCoordinate2D(latitude:lat!, longitude: long!)
        descEn.text = user.descriptionEn
        descAr.text = user.descriptionAr
        
    }
    
    //MARK: - form validation
    private func  formIsvalid() -> Bool {
        
        let title = "Edit Store Profile".localized
        
        var trimmedStr = storeNameEn.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr!.count < 2 {
            let msg = "Please enter valid Store name En".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        trimmedStr = storeNameAr.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedStr!.count < 2 {
            let msg = "Please enter valid Store name Ar".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        if  isValid(email: email.text!) == false {
            let msg = "Please enter valid email".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  (phone.text?.count)! < 6{
            let msg = "Please enter valid phone number".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (address.text?.count)! < 2 {
            let msg = "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (descEn.text?.count)! < 2 {
            let msg = "Please enter valid Description in English".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (descAr.text?.count)! < 2 {
            let msg = "Please enter valid Description in Arabic".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        return true
    }
    
    
    //MARK:-  actions
    
    @IBAction func saveBtnTapped(_ sender: UIButton) {
      
        self.sharedVC?.view.endEditing(true)
        if formIsvalid() {
            requestToUpdateProfile()
        }
       
    }
    
    
    
    //MARK:-  web services
    
    func requestToUpdateProfile() {
    
        let locale = myDefaultLanguage == .en ? "en":"ar"
        var params = ["locale": locale] as [String: Any]
        params.updateValue(storeNameEn.text!, forKey: "storeNameEn")
        params.updateValue(storeNameAr.text!, forKey: "storeNameAr")
        params.updateValue(descEn.text!, forKey: "descriptionEn")
        params.updateValue(descAr.text!, forKey: "descriptionAr")
        params.updateValue(phone.text!, forKey: "phone")
        params.updateValue(address.text!, forKey: "address")
        params.updateValue(location!.latitude, forKey: "latitude")
        params.updateValue(location!.longitude, forKey: "longitude")
        
        if let path = imagePath {
            params.updateValue(path, forKey: "image")
        }
        
//        saveBtn.startAnimate(view: self.contentView)
        ProfileManager.shared.editProfile(params: params) { (result) in
//            self.saveBtn.stopAnimate(view: self.contentView)
            self.imagePath = nil
            
            switch result {
            case .sucess(let root):
                AppSettings.shared.setLoggedInUser(user: root.data)
                if let image = self.newImage {
                      self.myImage.setPath(image: root.data?.image, placeHolder: image)
                }
                nvMessage.showSuccess(title: "Edit Profile".localized, body: root.message ?? "", closure: {
                    self.sharedVC?.navigationController?.popViewController(animated: true)
                })
                
            case .failure(let error):
                nvMessage.showError(body: error)
                
            }
        }
        
    }
    
   
    
    
}

extension EditStoreProfileTableViewCell:BaseImagePickerTableViewCellDelegate {
    
    func mySelectedImage(image: UIImage) {
        self.myImage.image = image
        self.newImage = image
        
        self.attachBtn.showLoading(view: contentView )
        self.progressLabel.isHidden = false
       
        SocketEventManager.shared.uploadImage(image: image) { (result) in
            
            switch result {
                
            case .progress(let value):
                self.progressLabel.text = "\(Int(value))%"
            
            case .path(let fileName):
                
                self.attachBtn.hideLoading(view: self.contentView)
                self.imagePath = fileName
                self.progressLabel.isHidden = true
                self.requestToUpdateProfile()
            }
            
        }
        
    }
    
}
