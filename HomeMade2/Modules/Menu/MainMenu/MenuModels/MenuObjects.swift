//
//  SettingModels.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit




enum MenuTypes {
    case profile
    case myOrders
    case ratingReviews
    case paymentProfile
    case settings
    case termsAndConditions
    case privacyPolicy
    case aboutUs
    case contactUs
    case logout
    case login
    case unknown
}


struct MenuItem {
    var title : String = ""
    var image : String = ""
    var type : MenuTypes = .unknown
    
    
    init(title : String, image : String, type : MenuTypes) {
        self.title = title
        self.image = image
        self.type = type
    }
    
    static func settingItem(title : String, image : String, type : MenuTypes) -> MenuItem{
        return MenuItem(title: title, image: image, type: type)
    }
    static func buyerMenu() -> [MenuItem]{
        return [
            MenuItem.settingItem(title: "Profile".localized, image: "profile", type: .profile),
            MenuItem.settingItem(title: "My Orders".localized, image: "myorder", type: .myOrders),
            MenuItem.settingItem(title: "Settings".localized, image: "settings", type: .settings),
            MenuItem.settingItem(title: "Terms & Conditions".localized, image: "termcondition", type: .termsAndConditions),
            MenuItem.settingItem(title: "Privacy Policy".localized, image: "privacypolicy", type: .privacyPolicy),
            MenuItem.settingItem(title: "About Us".localized, image: "aboutus", type: .aboutUs),
            MenuItem.settingItem(title: "Contact Us".localized, image: "contactus", type: .contactUs),
            MenuItem.settingItem(title: "Logout".localized, image: "logout", type: .logout),
        ]
    }
    static func sellerMenu() -> [MenuItem]{
        return [
            MenuItem.settingItem(title: "Profile".localized, image: "profile", type: .profile),
            MenuItem.settingItem(title: "My Orders".localized, image: "myorder", type: .myOrders),
            MenuItem.settingItem(title: "Raing & Reviews".localized, image: "rating_reviews", type: .ratingReviews),
            MenuItem.settingItem(title: "Payment Profile".localized, image: "paymentProfile", type: .paymentProfile),
            MenuItem.settingItem(title: "Settings".localized, image: "settings", type: .settings),
            MenuItem.settingItem(title: "Terms & Conditions".localized, image: "termcondition", type: .termsAndConditions),
            MenuItem.settingItem(title: "Privacy Policy".localized, image: "privacypolicy", type: .privacyPolicy),
            MenuItem.settingItem(title: "About Us".localized, image: "aboutus", type: .aboutUs),
            MenuItem.settingItem(title: "Contact Us".localized, image: "contactus", type: .contactUs),
            MenuItem.settingItem(title: "Logout".localized, image: "logout", type: .logout),
        ]
    }
    static func guestMenu() -> [MenuItem]{
        return [

            MenuItem.settingItem(title: "Settings".localized, image: "settings", type: .settings),
            MenuItem.settingItem(title: "Terms & Conditions".localized, image: "termcondition", type: .termsAndConditions),
            MenuItem.settingItem(title: "Privacy Policy".localized, image: "privacypolicy", type: .privacyPolicy),
            MenuItem.settingItem(title: "About Us".localized, image: "aboutus", type: .aboutUs),
            MenuItem.settingItem(title: "Contact Us".localized, image: "contactus", type: .contactUs),
            MenuItem.settingItem(title: "Login".localized, image: "logout", type: .login),
        ]
    }
}

