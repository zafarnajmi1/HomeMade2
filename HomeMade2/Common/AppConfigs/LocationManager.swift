//
//  LocationManager.swift
//  HomeMade2
//
//  Created by Apple on 16/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import CoreLocation
class LocationManager : NSObject {
    static let shared = LocationManager()
    
    
    static var latitude : Double{
        get {
            if let loc = LocationManager.shared.currentLocation{
                return loc.coordinate.latitude
            }
            else{
                return 0.0
            }
        }
    }
    static var longitude : Double{
        get {
            if let loc = LocationManager.shared.currentLocation{
                return loc.coordinate.longitude
            }
            else{
                return 0.0
            }
        }
    }
    var isLocation : Bool = false
    var currentLocation : CLLocation? {
        didSet{
            isLocation = true
        }
    }
    var locationManager = CLLocationManager()
    private override init() {
    }
    
    func startUpdatingLocation(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    

}
extension LocationManager : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        currentLocation = locations[0]
        print("Location Updated to Latitude:\(currentLocation!.coordinate.latitude) Longitude:\(currentLocation!.coordinate.longitude)")
    }
}
