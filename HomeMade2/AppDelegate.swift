//
//  AppDelegate.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
//import FBSDKCoreKit
import FBSDKLoginKit
import GoogleSignIn
import IQKeyboardManagerSwift
import GooglePlaces
import GoogleMaps
import Firebase
import Toast_Swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        GIDSignIn.sharedInstance()?.clientID = "400818382231-2r35lrl3i91dtpt1v1c8jucic2a5bvvu.apps.googleusercontent.com"
//        GMSPlacesClient.provideAPIKey("AIzaSyB94MKwU5wRvADF2o9xioRSLp8Te1zUEDc")//AIzaSyCaF2LSRHDzC-NdWZg_c1cQIbmWjiEX2Kw")
//        GMSServices.provideAPIKey("AIzaSyB94MKwU5wRvADF2o9xioRSLp8Te1zUEDc")//AIzaSyCaF2LSRHDzC-NdWZg_c1cQIbmWjiEX2Kw")
        
//        let googleMapAPIKey =  "AIzaSyBnW1wbtDB6F5-mwXF_Y2uJ-m-_22ef-x8"
//        let googlePlacesAPIKey = "AIzaSyBnW1wbtDB6F5-mwXF_Y2uJ-m-_22ef-x8"
        
        GMSServices.provideAPIKey(GOOGLE_API_KEY)
        GMSPlacesClient.provideAPIKey(GOOGLE_API_KEY)
        PayPalMobile.initializeWithClientIds(forEnvironments: [PayPalEnvironmentSandbox: "AR9DVJvSCQyaYqojNmNyjPaz14YM17PkPJ3KlyCbDfEOg4WYZAYctEF5s6Dxkxx-jVWva2xCXOXHWGvl"])
        
//        FirebaseApp.configure()
//        let manager = PushNotificationManager()
//        manager.registerForPushNotifications()
//        GMSPlacesClient.provideAPIKey(googleMapAPIKey)
        
        IQKeyboardManager.shared.enable = true
        LocationManager.shared.startUpdatingLocation()
        
        // Override point for customization after application launch.
        return true
    }
    
    
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        let handled = ApplicationDelegate.shared.application(app, open: url, options: options) || (GIDSignIn.sharedInstance()?.handle(url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation]) ?? false)
        return handled

    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func moveToRootMainVC() {
//        let board = AppConstant.storyBoard.main
//        let vc = board.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        
//        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "TabbarVC") as! TabbarVC
        
        
        
        let vc = TabbarVC.viewController()
        
//        if AppSettings.loggedInUser()?.accountType == "seller"{
//            var vcs = vc.viewControllers
//            vcs?.remove(at: 2)
//            vc.viewControllers = vcs
//        }
//        else{
//            
//        }
        
//        let favNav = vc.viewControllers?[2] as! BaseNavVC
//        favNav.viewControllers = [FavouriteVC.vc()]
        
        
        self.window?.switchRootViewController(vc)
        self.window?.makeKeyAndVisible()
//        setViewDirectionByLanguage()
    }
    func moveToLogin() {

        let vc = SelectLoginVC.viewController()
        let navVC = BaseNavVC(rootViewController: vc)
        self.window?.switchRootViewController(navVC)
        self.window?.makeKeyAndVisible()
        //        setViewDirectionByLanguage()
    }


}

