//
//  SocialRegisterBaseCell.swift
//  HomeMade2
//
//  Created by Apple on 24/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker
import MapKit

class SocialRegisterBaseCell: UITableViewCell {
    
    @IBOutlet weak var txt_email: UITextField!
    @IBOutlet weak var txt_phoneNumber: UITextField!
    @IBOutlet weak var txt_address: UITextField!
    
    @IBOutlet weak var lbl_email: UILabel!
    @IBOutlet weak var lbl_address: UILabel!
    @IBOutlet weak var lbl_phone: UILabel!
    
    weak var profileModel: SocialUser!
    weak var sharedVC: UIViewController?
    var location: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()

    override func awakeFromNib() {
        super.awakeFromNib()
        txt_email.addleftRightPading()
        txt_phoneNumber.addleftRightPading()
        txt_address.addleftRightPading()
        txt_address.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(model: SocialUser)  {
        self.profileModel = model
    }
    func moveToPlacePicker() {
        
        self.sharedVC?.view.endEditing(true)
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        sharedVC?.present(placePicker, animated: true, completion: nil)
    }

}
extension SocialRegisterBaseCell : UITextFieldDelegate {
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        sharedVC?.view.endEditing(true)
        self.contentView.endEditing(true)
        
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        self.sharedVC?.present(placePicker, animated: true, completion: nil)
        return false
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//
//        if textField == self.txt_address {
//            textField.resignFirstResponder()
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
extension SocialRegisterBaseCell: GMSPlacePickerViewControllerDelegate {
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
