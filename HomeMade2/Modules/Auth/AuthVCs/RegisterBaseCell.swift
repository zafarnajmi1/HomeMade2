//
//  RegisterBaseCell.swift
//  HomeMade2
//
//  Created by Apple on 23/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

import GoogleMaps
import GooglePlacePicker
import MapKit

class RegisterBaseCell: UITableViewCell{
//    @IBOutlet weak var txt_firstName: UITextField!
//    @IBOutlet weak var txt_lastName: UITextField!
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_phoneNumber: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBOutlet weak var txt_confirmPassowrd: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    
    
//    @IBOutlet weak var btn_registerUser: UIButton!
//    @IBOutlet weak var btn_registerSuplier: UIButton!
//    @IBOutlet weak var lbl_firstName: UILabel!
//    @IBOutlet weak var lbl_lastName: UILabel!
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_password: UILabel!
    @IBOutlet weak var lbl_confirmPassowrd: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
//    @IBOutlet weak var lbl_selectGender: UILabel!
//    @IBOutlet weak var btn_male: UIButton!
//    @IBOutlet weak var btn_female: UIButton!
    var sharedVC: UIViewController?
    var location: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        txt_address.delegate = self
//        txt_address.isUserInteractionEnabled = false
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func moveToPlacePicker() {
        
        self.sharedVC?.view.endEditing(true)
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        sharedVC?.present(placePicker, animated: true, completion: nil)
    }
    

}
extension RegisterBaseCell : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        sharedVC?.view.endEditing(true)
        self.contentView.endEditing(true)
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        self.sharedVC?.present(placePicker, animated: true, completion: nil)
        
        return false
    }
    
    @IBAction func onclick_address(_ sender : UIButton){
    
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == self.txt_address {
//            textField.superview?.endEditing(true)
////            textField.resignFirstResponder()
//            sharedVC?.view.endEditing(true)
//            self.contentView.endEditing(true)
//
//            let config = GMSPlacePickerConfig(viewport: nil)
//            let placePicker = GMSPlacePickerViewController(config: config)
//            placePicker.delegate = self
//
//            self.sharedVC?.present(placePicker, animated: true, completion: nil)
//        }
//    }
    
    
}
extension RegisterBaseCell: GMSPlacePickerViewControllerDelegate {
    
    
    
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
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
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
