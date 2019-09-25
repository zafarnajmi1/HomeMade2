//
//  GoogleLoginManager.swift
//  HomeMade2
//
//  Created by Apple on 17/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn

class GoogleLoginManager : NSObject  {
    
    var successCallback : ((GIDGoogleUser?, String?) -> Void)?
    
    static func checkGoogleLogin() -> Bool {
        guard let google = GIDSignIn.sharedInstance()
            else{
                return false
        }
        if google.hasAuthInKeychain() {
            return true
        }
        else{
            return false
        }
    }
    
    func loginWithGoogle(success successCallback: @escaping (GIDGoogleUser?, String?) -> Void){
        
        
        guard let google = GIDSignIn.sharedInstance()
            else{
                successCallback(nil, "Unknown Error".localized)
                return
        }
        self.successCallback = successCallback
        google.scopes = ["profile", "email"]
        google.delegate = self
        google.uiDelegate = self
        if google.hasAuthInKeychain(){
            google.signInSilently()
        }
        else{
            google.signIn()
//            google.signIn()
        }
        
    }
    static func logout(){
        guard let google = GIDSignIn.sharedInstance()
            else{
                return
        }
        google.signOut()
    }
    

}
extension GoogleLoginManager : GIDSignInDelegate, GIDSignInUIDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let successCallback = successCallback{
            if let error = error {
                
                successCallback(nil, error.localizedDescription)
                
                
                print("Google Login Error :\(error.localizedDescription)")
            }
            else{
                successCallback(user, nil)
            }
            
        }
//        print("Google Signin :\(signIn)")
//        print("Google User :\(user)")
    }
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
//        UIApplication.shared.keyWindow?.rootViewController?.present(viewController, animated: true, completion: nil)
        print("Presenting VC")
    }
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        print("Dismissing VC")
    }
    
//    - (void)signIn:(GIDSignIn *)signIn presentViewController:(UIViewController *)viewController;
//
//    // If implemented, this method will be invoked when sign in needs to dismiss a view controller.
//    // Typically, this should be implemented by calling |dismissViewController| on the passed
//    // view controller.
//    - (void)signIn:(GIDSignIn *)signIn dismissViewController:(UIViewController *)viewController;
    
    
}
