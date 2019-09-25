//
//  ProfileManager.swift
//  TailerOnline
//
//  Created by apple on 4/2/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper


class ProfileManager: RequestManager{

//    static let shared = ProfileManager()
//    private override init() {}
    
//    func changePassword(params: [String:Any], completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + profile.authChangePassword



        // make calls with the session manager
        func changePasswordlogin(params: [String:Any], completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            

            print("Parameters :\(params)")

            let url = CHANGE_PASSWORD
            
            print("Change Password in Cart:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("Change Password API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("Change Password API Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
    
    
//    func getProfile(completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + profile.authProfile
        // make calls with the session manager
    func getProfile(completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        

        let url = GET_PROFILE
        
        print("GET PROFILE in URL:\(url)")
        
        self.request(url, method: .get, parameters: nil) { (response) in
            print("GET PROFILE API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("GET PROFILE API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    
    
//    func editProfile(params:[String:Any] ,completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + profile.authUpdateProfile
    
        // make calls with the session manager
    func editProfile(params:[String:Any], completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
        
        
        let url = UPDATE_PROFILE
        
        print("Update Profiel URL:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Update Profiel  API Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Update Profiel API Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    
//    func updateStorePaypalCredentials(params:[String:Any] ,completion:@escaping (Response<LoginResponse,String>) -> Void) {
//
//        let path = basePath + profile.authUpdateStorePaypalCredentials
    
        // make calls with the session manager
        func updateStorePaypalCredentials(params:[String:Any], completionHandler: @escaping (LoginAPIResponse?, String?) -> Void){
            
            
            let url = UPDATE_STORE_PAYPAL_CREDENTIALS
            
            print("Update Store Paypal Credentials URL:\(url)")
            
            self.request(url, method: .post, parameters: params) { (response) in
                print("Update Store Paypal Credentials API Response :\(response)")
                
                if let error = self.checkError(Response: response){
                    completionHandler (nil, error)
                }
                else{
                    do {
                        let apiResponse = try JSONDecoder().decode(LoginAPIResponse.self, from: response.data!)
                        completionHandler(apiResponse, nil)
                    }
                    catch let error {
                        print("Update Store Paypal CredentialsAPI Failed :\(error)")
                        let error = self.parsingError
                        completionHandler(nil, error)
                    }
                    
                    
                }
            }
        }
    func getMyStoreReviews(skip : Int = 0, completionHandler: @escaping (MyStoreRattingReviewsAPIResponse?, String?) -> Void){
        
        let params = ["skip":skip] as [String : Any]
        
        print("Parameters :\(params)")
        let url = MY_STORE_REVIEWS
        
        print("GET STORE REVIEWS:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("GET STORE REVIEWS Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(MyStoreRattingReviewsAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("GET STORE REVIEWS Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    
//    func getPackages(completion:@escaping (Response<RootPackageModel,String>) -> Void) {
//        
//        let path = basePath + packages.authPackagesView
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .get,
//                                             parameters: nil,
//                                             encoding: JSONEncoding.default,
//                                             headers: authHeader() )
//        
//        request.responseObject { (response : DataResponse<RootPackageModel>) in
//            
//            print("ws Error: \(String(describing: response.error))")
//            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//            
//            switch response.result {
//            case .success(_):
//                
//                let object = response.result.value
//                
//                if (object?.success)! {
//                    completion(.sucess(object!))
//                }
//                else {
//                    let error = object?.message
//                    completion(.failure(error!))
//                }
//                
//                
//            case .failure(let error):
//                let error = error.localizedDescription
//                if error.contains(AppConstant.error.objectMapper) {
//                    completion(.failure(AppConstant.error.serverIssue))
//                }
//                else {
//                    completion(.failure(error))
//                }
//            }
//            
//        }
//    }
    
//    func fetchPurchasePackage(params:[String:Any]? ,completion:@escaping (Response<RootPackageModel,String>) -> Void) {
//
//        let path = basePath + packages.authPackagesPurchase
//
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: authHeader() )
//
//        request.responseObject { (response : DataResponse<RootPackageModel>) in
//
//            print("ws Error: \(String(describing: response.error))")
//            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//
//            switch response.result {
//            case .success(_):
//
//                let object = response.result.value
//
//                if (object?.success)! {
//                    completion(.sucess(object!))
//                }
//                else {
//                    let error = object?.message
//                    completion(.failure(error!))
//                }
//
//
//            case .failure(let error):
//                let error = error.localizedDescription
//                if error.contains(AppConstant.error.objectMapper) {
//                    completion(.failure(AppConstant.error.serverIssue))
//                }
//                else {
//                    completion(.failure(error))
//                }            }
//
//        }
//    }
}
