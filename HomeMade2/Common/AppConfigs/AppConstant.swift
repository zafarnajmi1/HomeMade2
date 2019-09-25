//
//  ImageConstants.swift
//  TailerOnline
//
//  Created by apple on 3/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import UIKit



//FIXME: struct nameType ( add Post Fix as Type In struct)

class AppConstant {
    
    struct loginOrSignup {
        static var login = false
        static var signup = false //show 10 items in per page
    }
    
    struct defaults {
        static let pagination = 20
        static let homePagination = 10 //show 10 items in per page
    }
    
    struct error {
        static let objectMapper = "ObjectMapper failed to serialize response."
        static let serverIssue = "Something went wrong, please try later.".localized
    }
    
    struct storyBoard {
        static let userEntry =  UIStoryboard(name: "UserEntry", bundle: nil)
        static let quotation = UIStoryboard(name: "Quotation", bundle: nil)
        static let cart = UIStoryboard(name: "Cart", bundle: nil)
        static let chat = UIStoryboard(name: "Chat", bundle: nil)
        static let order = UIStoryboard(name: "Order", bundle: nil)
        static let main =  UIStoryboard(name: "Main", bundle: nil)
        static let profile =  UIStoryboard(name: "Profile", bundle: nil)
        static let aboutUs = UIStoryboard(name: "AboutUs", bundle: nil)
        
    }

    

   
    
    
}
struct PlaceHolder {
    
    
    
    static let user =  UIImage(named: "")
    static let image =  UIImage(named: "image_placeholder")
    static let hms_placeHolder_large =  UIImage(named: "hms_placeholder_large")
    static let hms_placeHolder_medium =  UIImage(named: "hms_placeholder_medium")
    static let hms_placeHolder_small =  UIImage(named: "hms_placeholder_small")
    //        static let quotation = UIStoryboard(name: "Quotation", bundle: nil)
    //        static let cart = UIStoryboard(name: "Cart", bundle: nil)
    //        static let chat = UIStoryboard(name: "Chat", bundle: nil)
    //        static let order = UIStoryboard(name: "Order", bundle: nil)
    //        static let main =  UIStoryboard(name: "Main", bundle: nil)
    //        static let profile =  UIStoryboard(name: "Profile", bundle: nil)
    //        static let aboutUs = UIStoryboard(name: "AboutUs", bundle: nil)
    
}





