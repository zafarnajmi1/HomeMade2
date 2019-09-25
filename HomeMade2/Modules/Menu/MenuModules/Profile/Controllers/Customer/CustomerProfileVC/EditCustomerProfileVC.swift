//
//  EditCustomerProfileVC.swift
//  TailerOnline
//
//  Created by apple on 3/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlacePicker
import MapKit
import ObjectMapper


class EditCustomerProfileVC: BaseImagePickerVC {

    //MARK:- outlets
    
    @IBOutlet weak var txt_firstName: UITextField!
    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_phoneNumber: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    @IBOutlet weak var btn_editImage: UIButton!
    @IBOutlet weak var img_profile: UIImageView!
    
    
    @IBOutlet weak var lbl_progress: UILabel!
    @IBOutlet weak var lbl_firstName: UILabel!
    @IBOutlet weak var lbl_lastName: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    
    
    @IBOutlet weak var btn_male: UIButton!
    @IBOutlet weak var btn_female: UIButton!
    
    var gender = "male"
    var user : User?
    

    var location: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var imagePath : String?
    var userID : String?
     //MARK:- properties
    var profileModel: LoginAPIResponse!
    
    //MARK:-  my life cycle
    static func viewController() -> EditCustomerProfileVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "EditCustomerProfileVC") as! EditCustomerProfileVC
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func setupView() {
        setBackBarButton()
        btn_editImage.layer.cornerRadius = btn_editImage.frame.width/2
        btn_editImage.clipsToBounds = true
        self.title = "EDIT PROFILE".localized
        if let user = user{
            txt_firstName.text = user.firstName
            txt_lastName.text = user.lastName
            txt_email.text = user.email
            txt_phoneNumber.text = user.phone
            txt_address.text = user.address
            img_profile.kf.setImage(with: URL(string: user.image ?? ""), placeholder: UIImage(named: "placeholder_user"))
            user.gender == "male" ? onClick_male(btn_male!) : onClick_female(btn_female!)
            if let location = user.location{
                if location.count > 0 {
                    
                    
                    self.location = CLLocationCoordinate2DMake(location[1] ,  location[0])
                }
            }
        }
        
    }
    
    //MARK:- IBActions
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
    @IBAction func onClick_save(_ sender: Any) {
        view.endEditing(true)
        if !self.formIsvalid() {return}

        self.requestToUpdateProfile()
    }
    @IBAction func onClick_profilePic(_ sender: Any) {
        
        showImagePicker()
    }
    
    //MARK:-  web services
    
    func requestToUpdateProfile() {

        var params = ["firstName": txt_firstName.text!,
                      "lastName": txt_lastName.text!,
                      "email": txt_email.text!,
                      "phone": txt_phoneNumber.text!,
                      "gender": gender,
                      "address": txt_address.text!,
                      "latitude": location!.latitude,
                      "longitude": location!.longitude,
                      "locale": AppSettings.shared.myLanguage == .en ? "en" : "ar"
            ] as [String: Any]
        
        if let path = self.imagePath {
            params.updateValue(path, forKey: "image")
        }
        
        print("Update Profile Parameters :\(params)")
        
        startAnimating()
        ProfileManager().editProfile(params: params) { [weak self] (response, error) in
            if self?.checkResponse(response: response, error: error) ?? false{
                AppSettings.shared.setLoggedInUser(user: response?.data)
                //                if let image = self.newImage {
                //                    self.myImage.setPath(image: root.data?.image, placeHolder: image)
                //                }
                nvMessage.showSuccess(title: "Edit Profile".localized, body: response?.message ?? AppSettings.defaultSuccess, closure: {
                    self?.navigationController?.popViewController(animated: true)
                })
            }
        }
//        ProfileManager().editProfile(params: params) { [weak self] (result) in
//            self?.stopAnimating()
//
//
//
//            switch result {
//            case .sucess(let root):
//                AppSettings.shared.setLoggedInUser(user: root.data)
////                if let image = self.newImage {
////                    self.myImage.setPath(image: root.data?.image, placeHolder: image)
////                }
//                nvMessage.showSuccess(title: "Edit Profile".localized, body: root.message ?? "", closure: {
//                    self?.navigationController?.popViewController(animated: true)
//                })
//
//            case .failure(let error):
//                nvMessage.showError(body: error)
//
//            }
//        }
        
    }
    override func uploadImage(image: UIImage) {

//            self.attachBtn.showLoading(view: contentView )
        img_profile.image = image
        btn_editImage.isHidden = true
        lbl_progress.isHidden = false
        startAnimating()
            uploadImage(image: image) { [weak self] (result) in
                
                switch result {
                    
                case .failure(let error):
                    self?.stopAnimating()
                    self?.showError(body: error)
                case .progress(let value):
                    print("Progress : \(Int(value))%")
                    self?.lbl_progress.text = "\(Int(value))%"
                case .path(let fileName):
                    self?.stopAnimating()
                    self?.lbl_progress.isHidden = true
                    self?.btn_editImage.isHidden = false
                    
//                    self.attachBtn.hideLoading(view: self.contentView)
                    self?.img_profile.kf.setImage(with: URL(string: fileName), placeholder: image)
                    self?.imagePath = fileName
                    self?.onClick_save(UIButton())
//                    self?.requestToUpdateProfile()
                }
                
            }
            
        
    }
    //MARK: - form validation
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
        
        return true
    }
//    func uploadImage(image: UIImage,completion:@escaping (UploadResponse<Double,String>) -> Void) {
//
//        let socket = SocketIOManager.sharedInstance.getSocket()
//
//        let selectedImageResized = image.resizeImage(newHeight: 600)
//
//
//
//        let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
//
//        let imageSize : Int  = imagedata.length
//        print("Upload Image Size :\(Double(imageSize))")
//        print( imagedata as Data)
//
//
//        let ImageDataToServer: [String:Any] = ["name": "test.png",
//                                               "size": Double(imageSize)]
//        //        print(ImageDataToServer)
//        print("Socket EMIT startFileUpload")
//        socket.emit("startFileUpload", with: [ImageDataToServer])
//
//        socket.on("startUpload"){(data, ack)in
//            let changeData = (data[0] as AnyObject)
//            let ImagDictinary = changeData as! [String:AnyObject]
//            print("Socket ON startUpload \(ImagDictinary)")
//        }
//
//
//        let imgData = imagedata as Data
//        let uploadChunksize = 102400
//        let totalsize = imgData.count
//        var offset = 0
//
//        socket.on("moreData"){(data, ack)in
//
//            let modified = (data[0] as AnyObject)
//            let OtherImageDictinary = modified as! [String: AnyObject]
//            let moredata = MoreData(dictionary: OtherImageDictinary as NSDictionary)
//            print("Socket ON moreData \(OtherImageDictinary)")
//
//            completion(.progress(moredata?.data?.percent ?? 0))
//
//
//            let imageData = imagedata as Data
//
//            imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
//                let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
//                print(totalsize)
//
//                let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
//                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
//                offset += chunkSize
//
//                let chunkSize2 = chunk.count
//
//                let imageDataupload:[String : Any]  = [
//                    "fileName":   "test.png",
//                    "data" : chunk as NSData ,
//                    "pointer" : moredata!.data!.pointer! ,
//                    "chunkSize" : chunkSize2
//                ]
//
//
//                print(imageDataupload)
//                print("Socket EMIT uploadChunk")
//                socket.emit("uploadChunk", with: [imageDataupload])
//
//            }
//        }
//
//        socket.on("uploadCompleted") { (data, ack) in
//
//
//            print("Socket ON uploadCompleted")
//
//            socket.off("startUpload")
//            socket.off("moreData")
//            socket.off("uploadCompleted")
//
//            let modified =  (data[0] as AnyObject)
//
//            //Map your response Object
//            if let rootModel = Mapper<RootUploadCompleteModel>().map(JSONObject: modified) {
//                let path = (rootModel.data?.fileName!)!
//                completion(.path(path))
//            }
//            else {
//                //                nvMessage.showStatusError(body: "Response Changed")
//            }
//
//
//
//
//        }
//    }
    func uploadImage(image : UIImage, completion: @escaping (UploadResponse<Double,String,String>) -> Void) {
        
        let socket = SocketIOManager.sharedInstance.getSocket()
        
        let selectedImageResized = image.resizeImage(newHeight: 600)
        
        
        
        let imagedata : NSData = NSData(data: selectedImageResized.jpegData(compressionQuality: 1.0)!)
        
        let imageSize : Int  = imagedata.length
        print("Upload Image Size :\(Double(imageSize))")
        print( imagedata as Data)
        
        
        let ImageDataToServer: [String:Any] = ["name": "test.png",
                                               "size": Double(imageSize)]
        //        print(ImageDataToServer)
        print("Socket EMIT startFileUpload")
        socket.emit("startFileUpload", with: [ImageDataToServer])
        
        socket.on("startUpload"){(data, ack)in
            let changeData = (data[0] as AnyObject)
            let ImagDictinary = changeData as! [String:AnyObject]
            print("Socket ON startUpload \(ImagDictinary)")
        }
        
        
        let imgData = imagedata as Data
        let uploadChunksize = 102400
        let totalsize = imgData.count
        var offset = 0
        
        socket.on("moreData"){(data, ack)in
            
            let modified = (data[0] as AnyObject)
            let OtherImageDictinary = modified as! [String: AnyObject]
            let moredata = MoreData(dictionary: OtherImageDictinary as NSDictionary)
            print("Socket ON moreData \(OtherImageDictinary)")
            
            completion(.progress(moredata?.data?.percent ?? 0))
            
            
            let imageData = imagedata as Data
            
            imageData.withUnsafeBytes{(u8Ptr:UnsafePointer<UInt8>)in
                let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
                print(totalsize)
                
                let chunkSize = offset + uploadChunksize > totalsize ? totalsize - offset : uploadChunksize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                offset += chunkSize
                
                let chunkSize2 = chunk.count
                
                let imageDataupload:[String : Any]  = [
                    "fileName":   "test.png",
                    "data" : chunk as NSData ,
                    "pointer" : moredata!.data!.pointer! ,
                    "chunkSize" : chunkSize2
                ]
                
                
                print(imageDataupload)
                print("Socket EMIT uploadChunk")
                socket.emit("uploadChunk", with: [imageDataupload])
                
            }
        }
        
        socket.on("uploadCompleted") { (data, ack) in
            
            
            print("Socket ON uploadCompleted")
            
            socket.off("startUpload")
            socket.off("moreData")
            socket.off("uploadCompleted")
            
            let modified =  (data[0] as AnyObject)
            
//            if let error = self.checkError(Response: modified){
////                completionHandler (nil, error)
//            }
//            else
//            {
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: modified, options: .prettyPrinted)
                // here "jsonData" is the dictionary encoded in JSON data
                do {
                    let apiResponse = try JSONDecoder().decode(UploadDataResponse.self, from: jsonData)
                    
                    let path = (apiResponse.data?.fileName!)!
                    completion(.path(path))
                    
                    //                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Parsing Data to Object Error :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completion(.failure(error))
//                    self.showError(body: error)
                    //                    completionHandler(nil, error)
                }
                
            } catch let error {
                print("Dictionary to Data error :\(error)")
                let error = "Something went wrong, please try again later".localized
                completion(.failure(error))
//                self.showError(body: error)
//                print(error.localizedDescription)
            }
            
            
            
                
                
//            }
            
            
            
            
            //Map your response Object
//            if let rootModel = Mapper<RootUploadCompleteModel>().map(JSONObject: modified) {
//                let path = (rootModel.data?.fileName!)!
//                completion(.path(path))
//            }
//            else {
//
//                //                nvMessage.showStatusError(body: "Response Changed")
//            }
            
            
            
            
        }
    }
    
    
}
extension EditCustomerProfileVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
        return false
    }
}
extension EditCustomerProfileVC: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.txt_address.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinates: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.txt_address.text = "Unkown Address, \(coordinate)"
        }
        
        
    }
    
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        print("No place selected")
    }
    
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        nvMessage.showError(body: "didFailAutocompleteWithError" )
    }
    
    // Show the network activity indicator.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // Hide the network activity indicator.
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    
}
