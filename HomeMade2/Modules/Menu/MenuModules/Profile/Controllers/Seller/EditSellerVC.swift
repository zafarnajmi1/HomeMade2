//
//  EditSellerVC.swift
//  HomeMade2
//
//  Created by Afrah Tayyab on 6/19/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlacePicker
import MapKit
import ObjectMapper

class EditSellerVC: BaseImagePickerVC {
    //MARK: Properties
    //MARK: Outlets
    @IBOutlet weak var imgStore: UIImageView!
    @IBOutlet weak var txtFldStoreName: UITextField!
    @IBOutlet weak var txtFldStorePhoneNo: UITextField!
    @IBOutlet weak var txtFldStoreAddress: UITextField!
    @IBOutlet weak var txtDetail: UITextView!
    
    //MARK: Outlets for Localization
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhoneNo: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    @IBOutlet weak var lblProgress: UILabel!
    
    var detailPlaceHolder : String{
        return "Write Something About Your Store".localized
    }
    

    @IBOutlet weak var btnEditProfilePic: UIButton!{
        didSet{
            self.btnEditProfilePic.layer.cornerRadius = 5.0
        }
    }
    @IBOutlet weak var btnSave: UIButton!
    
    //For getting location...
    var location: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    var imagePath : String?
    
    //making var to access User Model
   // var user : User?
    var user = AppSettings.loggedInUser()
    static func viewController() -> EditSellerVC{
        
        return UIStoryboard.profileStoryboard.instantiateViewController(withIdentifier: "EditSellerVC") as! EditSellerVC
    }
    
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackBarButton()
        //Adding user's Data on the Text Fields...
        setupView()
        
        //PlaceHolder For Detail Text View
        txtDetail.delegate = self
        if txtDetail.text == ""{
            txtDetail.text = "Write Something About Your Store"
            txtDetail.textColor = UIColor.lightGray
        }else{
            txtDetail.text = user?.description
        }
        
        //giving padding in text vieew...
        self.txtDetail.contentInset = UIEdgeInsets(top: 8, left: 22, bottom: 8, right: 8);
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Edit Profile".localized
    }
    
    override func setupView() {
        
        self.title = "EDIT PROFILE".localized
        if let user = user{
            
            txtFldStoreName.text = user.storeName
            txtFldStorePhoneNo.text = user.phone
            txtFldStoreAddress.text = user.address
            
            if user.description != nil && user.description != "" {
                txtDetail.text = user.description
                
            }
            else{
                txtDetail.text = detailPlaceHolder
                txtDetail.textColor = .lightGray
            }
            
            
            
            imgStore.kf.setImage(with: URL(string: user.image ?? ""), placeholder: UIImage(named: "placeholder_user"))
            
            if let location = user.location{
                if location.count > 0 {
                    self.location = CLLocationCoordinate2DMake(location[1] ,  location[0])
                }
            }
        }
    }
    
    //MARK: - form validation
    private func  formIsvalid() -> Bool {
        
        let title = "Supplier".localized
        let stringValue = self.txtFldStoreName.text!
        let trimmedStr = stringValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedStr.count < 2 {
            
            let msg = "Please enter valid Store Name".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if  txtFldStorePhoneNo.text!.count < 9 || txtFldStorePhoneNo.text!.count > 15{
            let msg = "Phone number must be between 9-15 characters".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if (txtFldStoreAddress.text?.count)! < 2 {
            let msg = "Please enter valid address".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        
        if txtDetail.text!.isEmpty || txtDetail.text == detailPlaceHolder {
            let msg = "Please enter valid Store Details".localized
            nvMessage.showError(title: title, body: msg)
            return false
        }
        return true
    }

    @IBAction func btnSave(_ sender: Any){
        
      if !self.formIsvalid() {return}
        self.requestToUpdateProfile()
    }
    
    @IBAction func btnEditProffilePic(_ sender: Any){
        
       showImagePicker()
        
    }
    //MARK:-  web services
    
    func requestToUpdateProfile() {
//        params.updateValue(storeNameEn.text!, forKey: "storeNameEn")
//        params.updateValue(storeNameAr.text!, forKey: "storeNameAr")
        var params = ["email": AppSettings.loggedInUser()?.email ?? "--",
                      "storeNameEn": txtFldStoreName.text!,
                      "storeNameAr": txtFldStoreName.text!,
                      "phone": txtFldStorePhoneNo.text!,
                      "address": txtFldStoreAddress.text!,
                      "latitude": location!.latitude,
                      "longitude": location!.longitude,
                      "descriptionEn": txtDetail.text!,
                      "descriptionAr": txtDetail.text!,
                      "locale": AppSettings.shared.myLanguage == .en ? "en" : "ar"
            ] as [String: Any]
        
        if let path = self.imagePath {
            params.updateValue(path, forKey: "image")
        }
        
        print("Update Profile Parameters :\(params)")
        
        startAnimating()
        ProfileManager().editProfile(params: params) { [weak self]  (response, error) in
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
//            switch result {
//            case .sucess(let root):
//                AppSettings.shared.setLoggedInUser(user: root.data)
//                //                if let image = self.newImage {
//                //                    self.myImage.setPath(image: root.data?.image, placeHolder: image)
//                //                }
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
        imgStore.image = image
        btnEditProfilePic.isHidden = true
        lblProgress.isHidden = false
        startAnimating()
        uploadImage(image: image) { [weak self] (result) in
            
            switch result {

            case .failure(let error):
                self?.stopAnimating()
                self?.lblProgress.isHidden = true
                self?.btnEditProfilePic.isHidden = false
                self?.showError(body: error)
            case .progress(let value):
                print("Progress : \(Int(value))%")
                self?.lblProgress.text = "\(Int(value))%"
            case .path(let fileName):
                self?.stopAnimating()
                self?.lblProgress.isHidden = true
                self?.btnEditProfilePic.isHidden = false

                //                    self.attachBtn.hideLoading(view: self.contentView)
                self?.imgStore.kf.setImage(with: URL(string: fileName), placeholder: image)
                self?.imagePath = fileName
                
                self?.btnSave(UIButton())
//                self?.requestToUpdateProfile()
            }
            
        }
    }
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

extension EditSellerVC : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        present(placePicker, animated: true, completion: nil)
        return false
    }
}


//MARK: Adding google Place Picker in Text field.
extension EditSellerVC: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.txtFldStoreAddress.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinates: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.txtFldStoreAddress.text = "Unkown Address, \(coordinate)"
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

extension EditSellerVC: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if textView.text == detailPlaceHolder
        {
            textView.text = ""
        }
        txtDetail.textColor = UIColor.black
//        if txtDetail.textColor == UIColor.lightGray {
//            txtDetail.text = nil
//            txtDetail.textColor = UIColor.black
//        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = detailPlaceHolder
            textView.textColor = UIColor.lightGray
        }
    }
}
