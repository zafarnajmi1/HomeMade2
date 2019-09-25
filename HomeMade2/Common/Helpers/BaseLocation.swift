//
//  BaseLocationTableViewCell.swift
//  TailerOnline
//
//  Created by apple on 3/29/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlacePicker
import MapKit



class BaseLocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var address: UITextField!
    
    //MARK:- Properties
    var sharedVC: UIViewController?
    var location: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
    func moveToPlacePicker() {
        
        self.sharedVC?.view.endEditing(true)
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        sharedVC?.present(placePicker, animated: true, completion: nil)
    }
    
    
    //MARK:-  location setup
    @IBAction func locationBtnTapped(_ sender: UIButton) {
        sharedVC?.view.endEditing(true)
        self.contentView.endEditing(true)
        moveToPlacePicker()
    }
   
}



extension BaseLocationTableViewCell : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
    
        if textField == self.address {
            sharedVC?.view.endEditing(true)
            self.contentView.endEditing(true)
            
            let config = GMSPlacePickerConfig(viewport: nil)
            let placePicker = GMSPlacePickerViewController(config: config)
            placePicker.delegate = self
            
            self.sharedVC?.present(placePicker, animated: true, completion: nil)
        }
    }
    
    
}


extension BaseLocationTableViewCell: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.location = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.address.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.address.text = "Unkown Address, \(coordinate)"
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


extension BaseLocationTableViewCell: CLLocationManagerDelegate {
    
    fileprivate func determineMyCurrentLocation() {
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            
            
        }
    }
    
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            let error = "Location access was restricted."
            nvMessage.showError(body: error)
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            nvMessage.showError(body: "User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.stopUpdatingLocation()
        @unknown default:
            print("something went Wrong")
        }
    }
    
    // Handle location manager errors.
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locationManager.stopUpdatingLocation()
        let location = locations.last
        _ = location?.coordinate.latitude
        _ = location?.coordinate.longitude
        locationManager.stopUpdatingLocation()
        self.location = location?.coordinate
        
    }
}


class BaseLocationVC: UIViewController {
    
    @IBOutlet weak var address: UITextField!
    
    //MARK:- Properties
    var mySelectedLocation: CLLocationCoordinate2D?
    var locationManager = CLLocationManager()
    
   
    func moveToPlacePicker() {
        
        self.view.endEditing(true)
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        
        self.present(placePicker, animated: true, completion: nil)
    }
    
    
    //MARK:-  location setup
    @IBAction func locationBtnTapped(_ sender: UIButton) {
        moveToPlacePicker()
    }
}



extension BaseLocationVC: GMSPlacePickerViewControllerDelegate {
    // To receive the results from the place picker 'self' will need to conform to
    // GMSPlacePickerViewControllerDelegate and implement this code.
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        // Dismiss the place picker, as it cannot dismiss itself.
        viewController.dismiss(animated: true, completion: nil)
        
        //in self view
        self.mySelectedLocation = place.coordinate
        
        
        //formate address
        if place.formattedAddress != nil {
            self.address.text = place.formattedAddress!
        }
        else {
            let coordinate = "selected coordinat: \(place.coordinate.latitude), \(place.coordinate.longitude)"
            self.address.text = "Unkown Address, \(coordinate)"
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


extension BaseLocationVC: CLLocationManagerDelegate {
    
    fileprivate func determineMyCurrentLocation() {
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            
            
        }
    }
    
    
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            let error = "Location access was restricted."
            nvMessage.showError(body: error)
            
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            nvMessage.showError(body: "User denied access to location.")
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.stopUpdatingLocation()
        @unknown default:
            print("something went Wrong")
        }
    }
    
    // Handle location manager errors.
    internal func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // locationManager.stopUpdatingLocation()
        let location = locations.last
        _ = location?.coordinate.latitude
        _ = location?.coordinate.longitude
        locationManager.stopUpdatingLocation()
        self.mySelectedLocation = location?.coordinate
        
    }
}
