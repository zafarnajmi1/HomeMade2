//
//  AuthManager.swift
//  TailerOnline
//
//  Created by apple on 3/28/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper

class AuthManager: RequestManager {
    
//    static let shared = AuthManager()
   
//    func login(email: String, password: String, completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
//
//        let path = LOGIN //        var params: [String: Any] = ["email": email,
//                                     "password": password]
//        print("Parameters :\(params)")
//        if let token = AppUserDefault.shared.fcmToken {
//            params.updateValue(token, forKey: "fcm")
//        }
    
        func login(email: String, password: String, completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            

            var params: [String: Any] = ["email": email,
                                         "password": password]
            print("Parameters :\(params)")
            if let token = AppUserDefault.shared.fcmToken {
                params.updateValue(token, forKey: "fcm")
            }
            
            
            print("Parameters :\(params)")
            let url = LOGIN
            
            print("Update Item in Cart:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("Login API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("Login API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
    
    /////////////////////////////////////////////////////////////////////////
    

    
//    func register( params: [String: Any] , completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + auth.register




    func register( params: [String: Any] , completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        
        
        
        
        print("Parameters :\(params)")
//        if let token = AppUserDefault.shared.fcmToken {
//            params.updateValue(token, forKey: "fcm")
//        }
        
        
        print("Parameters :\(params)")
        let url = REGISTER
        
        print("REGISTER URL:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("REGISTER API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("REGISTER API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
//
//
//    func verificationCode(code: String, completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + auth.authEmailVerification
//
//        let params = ["verificationCode": code] as [String: Any]

        // make calls with the session manager
    func verificationCode(code: String, completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        
        
        
        let params = ["verificationCode": code] as [String: Any]
        
        print("Parameters :\(params)")
        let url = VERIFICATION_CODE
        
        print("verificationCode URL:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("verificationCode API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("verificationCode API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
//
//
//    func resendVerificationCode(completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + auth.authResendVerficationCode




        // make calls with the session manager
    func resendVerificationCode(completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        
        
        
        let url = RESEND_VERIFICATION_CODE
        
        print("RESEND VERIFICation Code URL:\(url)")
        
        self.request(url, method: .post, parameters: nil) { (response) in
            print("RESEND VERIFICation Code API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("RESEND VERIFICation Code API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
//
//
//
//    func forgotPassword(email: String, completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + auth.forgotPassword
//
//        let params = ["email": email] as [String: Any]

        // make calls with the session manager
        func forgotPassword(email: String,completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            
            let url = FORGOT_PASSWORD
            let params = ["email": email] as [String: Any]
            print("Parameters :\(params)")
            print("FORGOT Password URL:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("FORGOT Password API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("FORGOT Password API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
//
//
//    func resetPassword(params: [String:Any], completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + auth.resetPassword



        // make calls with the session manager
    func resetPassword(params: [String:Any] ,completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        
        
        
        let url = RESET_PASSWORD

        print("Parameters :\(params)")
        print("resetPassword URL:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("resetPassword API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("resetPassword API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
//
//
//     //MARK:-  Social Login Integrations
//
//    func socialLoginCheck(params:[String: Any],completion: @escaping(Response<LoginResponse,String>) -> Void) {
//
//        let path = self.basePath + auth.socialLoginCheck
        // make calls with the session manager
        func socialLoginCheck(params: [String:Any] ,completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            
            let url = SOCIAL_LOGIN_CHECK
            
            print("Parameters :\(params)")
            print("socialLoginCheck URL:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("socialLoginCheck API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("socialLoginCheck API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
//
//    func socialLoginRegister(params:[String: Any],completion: @escaping(Response<LoginResponse,String>) -> Void) {
//
//        let path = self.basePath + auth.socialLogin
        // make calls with the session manager
        func socialLoginRegister(params: [String:Any] ,completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            
            let url = SOCIAL_LOGIN
            
            print("Parameters :\(params)")
            print("socialLoginRegister URL:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("socialLoginRegister API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("socialLoginRegister API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
//    func contactUs(params:[String: Any], completion:@escaping (Response<LoginResponse, String>) -> Void){
//
//        let path = basePath + setting.contactus
        // make calls with the session manager
        func contactUs(params: [String:Any] ,completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            
            let url = CONTACT_US
            
            print("Parameters :\(params)")
            print("contactUs URL:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("contactUs API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("contactUs API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
}


