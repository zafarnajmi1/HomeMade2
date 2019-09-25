//
//  FBLoginManager.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FBSDKLoginKit





class FBLoginManager{
    
    
    static func checkFBLogin() -> Bool{
        if (AccessToken.current != nil) {
            return true
        }
        else{
            return false

        }

    }
    static func loginWithFacebook(success successCallback: @escaping (FBUser?, String?) -> Void){
        if (AccessToken.current != nil) {
            
            self.fbGraphRequest(success: successCallback)
        }
        else{
            self.fbLogin(success: successCallback)
        }
    }
    static func fbLogin(success successCallback: @escaping (FBUser?, String?) -> Void){
        let fb = LoginManager()
        fb.logIn(permissions: ["public_profile","email"], from: nil) { (result, error) in
            
            if let error = error {
                print("Login Error :\(error)")
                successCallback(nil, error.localizedDescription)
            }
            else{
                if result?.isCancelled ?? false {
                    print("User Canceld the request")
                    successCallback(nil, "User Canceled the request".localized)
                }
                else{
                    self.fbGraphRequest(success: successCallback)
                }
            }
            
        }
    
    }
    static func fbGraphRequest(success successCallback: @escaping (FBUser?, String?) -> Void){
        let graphRequest = GraphRequest.init(graphPath: "me", parameters: ["fields":"id,name,first_name,last_name,email,picture"])
        graphRequest.start { (connection, result, error) in
            if let error = error {
                
                print("Facebook Login Error :\(error)")
                successCallback(nil, error.localizedDescription)
            }
            else{
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: result ?? [:])
                    do {
                        let fbuser = try JSONDecoder().decode(FBUser.self, from: jsonData)
//                        print("Facebook User :\(fbuser)")
                        successCallback(fbuser, nil)
                    }
                    catch{
                        print("Parsing Error :\(error)")
                        successCallback(nil, "Facebook login failed due to unknown error".localized)
                    }
                } catch {
                    print("Converting to Data Error :\(error)")
                    successCallback(nil, "Facebook login failed due to unknown error".localized)
                }

                
                
                /*
                 ["first_name": Shah, "email": shah_yxcupja_khan@tfbnw.net, "id": 101280151115164, "last_name": Khan, "picture": {
                 data =     {
                 height = 50;
                 "is_silhouette" = 0;
                 url = "https://platform-lookaside.fbsbx.com/platform/profilepic/?asid=101280151115164&height=50&width=50&ext=1560591716&hash=AeTq1n0OEiWYp5iy";
                 width = 50;
                 };
                 }, "name": Shah Rukh Khan]
                 */
                
            }
        }
    }
    static func logout(){
        let fb = LoginManager()
        fb.logOut()
        AccessToken.current = nil
        
    }

}



