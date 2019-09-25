//
//  Storyboard.swift
//  HomeMade2
//
//  Created by Apple on 20/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


extension UIStoryboard{
    public static var authStoryboard: UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: Bundle.main)
    }
    public static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    public static var menuStoryboard: UIStoryboard {
        return UIStoryboard(name: "Menu", bundle: Bundle.main)
    }
    public static var profileStoryboard: UIStoryboard {
        return UIStoryboard(name: "Profile", bundle: Bundle.main)
    }
    public static var commonStoryboard: UIStoryboard {
        return UIStoryboard(name: "Common", bundle: Bundle.main)
    }
    public static var categoryStoryboard: UIStoryboard {
        return UIStoryboard(name: "Category", bundle: Bundle.main)
    }
    public static var product: UIStoryboard {
        return UIStoryboard(name: "Product", bundle: Bundle.main)
    }
    public static var home: UIStoryboard {
        return UIStoryboard(name: "Home", bundle: Bundle.main)
    }
    public static var chat: UIStoryboard {
        return UIStoryboard(name: "Chat", bundle: Bundle.main)
    }
    
    public static var broadCastStoryboard: UIStoryboard {
        
        
        return UIStoryboard(name: "Auth", bundle: Bundle.main)
        //        let bundle = Bundle.main
        //        guard let name = bundle.object(forInfoDictionaryKey: "BroadCast") as? String else {
        //            return UIStoryboard()
        //        }
        //        return UIStoryboard(name: name, bundle: bundle)
    }
}
