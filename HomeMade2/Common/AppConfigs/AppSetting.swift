//
//  AppSetting.swift
//  TailerOnline
//
//  Created by apple on 3/29/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit
import CoreLocation

enum AccountType:String {
    case guest
    case seller
    case buyer
    case none
}
var loggedInUserAccountType : AccountType{
    get {
        if AppSettings.isGuest(){
            return .guest
        }
        else if AppSettings.loggedInUser()?.accountType == "seller"{
            return .seller
        }
        else{
            return .buyer
        }
    }
}
class AppSettings {
    static let shared = AppSettings()
    
    var locationManager = CLLocationManager()
    
    private init() {
//        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    var loggedInUser : User?
    var settings: SettingData?
    var language : LanguageType?
    var currency : CurrencyType?
    private var unseenNotificationCount : Int = 0
    var unseenNotification : Int {
        set {
            
            unseenNotificationCount = newValue
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NOTIFICATIONS_UPDATED), object: nil, userInfo: nil)
//            NotificationCenter.post(name: NOTIFICATIONS_UPDATED, object: nil)
        }
        get{
            return unseenNotificationCount
        }
    }
    
    
    var myCurrency : CurrencyType {
        get{
            let defaults = UserDefaults.standard
            
            if let currency = currency {
                return currency
            }
            else{
                if let cr = defaults.value(forKey: "MyDefaultCurrency") as? String{
                    currency = cr == "usd" ? .usd : .aed
                    return currency!
                    
                }
                else{
                    return .aed
                }
            }
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue == .usd ? "usd": "aed", forKey: "MyDefaultCurrency")
            defaults.synchronize()
            currency = newValue
        }
    }
    
    var myLanguage : LanguageType {
        get{
            let defaults = UserDefaults.standard
            
            if let language = language {
                return language
            }
            else if let language = defaults.value(forKey: "MyDefaultLanguage") as? String{
                return language == "en" ? .en : .ar
                
            }
            else{
                language = .en
                return language!
            }
        }
        set {
            language = newValue
        }
    }
    
    var userToken : String? {
        return AppSettings.shared.loggedInUser?.authorization
    }
    var isUserLoggedIn : Bool {
        if loggedInUser == nil {
            return false
        }
        else{
            return true
        }
    }
    
    static func loggedInUser() -> User?{
        return AppSettings.shared.loggedInUser
    }

    static func isGuest() -> Bool {
        if AppSettings.shared.loggedInUser != nil{
            return false
        }
        else{
            return true
        }
    }
    func setLoggedInUser(user : User?)  {
        
        loggedInUser = user
    }
   
    func setSettings(model : SettingData?)  {
        settings = model
    }
    
    
}
extension AppSettings{
    
    
    static func printResponse(dictionary : [String: Any], message : String){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            // here "jsonData" is the dictionary encoded in JSON data
            
            let jsonString = String.init(data: jsonData, encoding: .utf8)
            print("\(message) :\(jsonString ?? "Unknown String")")
            //            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        catch let error {
            print("Dictionary to Data error :\(error)")
            
            //                self.showError(body: error)
            //                print(error.localizedDescription)
        }
    }
    
    static func getEmailPassword() -> (email : String, password : String)?{
        let defaults = UserDefaults.standard
        
        if let email : String = defaults.value(forKey: "Email") as? String, let password : String = defaults.value(forKey: "Password") as? String{
            return (email : email , password : password)
        }
        else{
            return nil
        }
        
    }
    
    static func setEmailPassword(email : String, password : String){
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "Email")
        defaults.set(password, forKey: "Password")
        defaults.synchronize()
    }
    static func removeEmailPassword(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "Email")
        defaults.removeObject(forKey: "Password")
//        defaults.set(email, forKey: "Email")
//        defaults.set(password, forKey: "Password")
        defaults.synchronize()
    }
    static func rememberMyLanguage(value : LanguageType){
        let defaults = UserDefaults.standard
        defaults.set(value == .en ? "en": "ar", forKey: "MyDefaultLanguage")
//        defaults.set(value == .en ?? "en": "ar", forKey: "")
        defaults.synchronize()
        
        AppSettings.shared.myLanguage = value
    }
    static func isLanguageRemembered() -> Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.value(forKey: "MyDefaultLanguage"){
            return true
            
            
        }
        else{
           return false
        }
    }
    static func forgetMyLanguage(){
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "MyDefaultLanguage")

        defaults.synchronize()
        AppSettings.shared.myLanguage = .en
    }
    static var language: LanguageType {
        return AppSettings.shared.myLanguage
    }
    static var languageString: String {
        return AppSettings.shared.myLanguage == .en ? "en" : "ar"
    }
    static var currency: CurrencyType {
        return AppSettings.shared.myCurrency
    }
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    static var defaultError : String{
        get {
            return "Something went wrong, please try again later".localized
        }
    }
    static var defaultSuccess : String{
        get {
            return "Your request has been processed".localized
        }
    }
    
//    static var myLanguage : String {
//
//        get{
//            let defaults = UserDefaults.standard
//
//            if let mylang = defaults.string(forKey: "MyDefaultLanguage"){
//                return mylang
//            }
//            else{
//                return "en"
//            }
//
//
//        }
//    }
}

// Scratch Pad to Keep tempData
extension AppSettings{
    
}
