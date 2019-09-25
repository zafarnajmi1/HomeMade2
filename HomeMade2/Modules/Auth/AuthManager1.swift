//
//  AuthManager.swift
//  TailerOnline
//
//  Created by apple on 3/28/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//


import Alamofire
import AlamofireObjectMapper

class AuthManager1: BaseManager {
    
    static let shared = AuthManager()
   
   
    
////    func login( email: String, password: String, completion:@escaping (Response<LoginResponse,String>) -> Void) {
////
////        let path = basePath + auth.login
////
////
////        var params: [String: Any] = ["email": email,
////                                     "password": password]
////
////        if let token = AppUserDefault.shared.fcmToken {
////            params.updateValue(token, forKey: "fcm")
////        }
////
////        // make calls with the session manager
////        let request = sessionManager.request(path,
////                                             method: .post,
////                                             parameters: params,
////                                             encoding: JSONEncoding.default,
////                                             headers: nil )
////
////        request.responseObject { (response : DataResponse<LoginResponse>) in
////
////            print("ws Error: \(String(describing: response.error))")
////            print("ws Response: \(String(describing: response.response))")
////            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
////                print("ws Data: \(utf8Text)")
////            }
////
////            switch response.result {
////            case .success(_):
////                let object = response.result.value
////                if (object?.success)! {
////                    //completion(object, nil)
////                    completion(.sucess(object!))
////                }
////                else {
////                    let error = object?.message
////                    completion(.failure(error!))
////                }
////
////
////            case .failure(let error):
////                print(error.localizedDescription)
////                completion(.failure(error.localizedDescription))
////            }
////
////        }
////    }
//    
//    
//    func register( params: [String: Any] , completion:@escaping (Response<LoginResponse,String>) -> Void) {
//        
//        let path = basePath + auth.register
//        
//        
//       
//        
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//            
////            print("ws Error: \(String(describing: response.error))")
////            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//            
//            switch response.result {
//            case .success(_):
//                let object = response.result.value
//                if (object?.success)! {
//                    //completion(object, nil)
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
//    
//    
//    func verificationCode(code: String, completion:@escaping (Response<LoginResponse,String>) -> Void) {
//        
//        let path = basePath + auth.authEmailVerification
//        
//        let params = ["verificationCode": code] as [String: Any]
//        
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: authHeader() )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//            
////            print("ws Error: \(String(describing: response.error))")
////            print("ws Response: \(String(describing: response.response))")
////            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
////                print("ws Data: \(utf8Text)")
////            }
//            
//            switch response.result {
//            case .success(_):
//                let object = response.result.value
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
//    
//    
//    func resendVerificationCode(completion:@escaping (Response<LoginResponse,String>) -> Void) {
//        
//        let path = basePath + auth.authResendVerficationCode
//        
//        
//        
//        
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: nil,
//                                             encoding: JSONEncoding.default,
//                                             headers: authHeader() )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//           
//            print("ws url: \(path)")
//            print("ws Error: \(String(describing: response.error))")
//            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//            
//            switch response.result {
//            case .success(_):
//                let object = response.result.value
//                if (object?.success)! {
//                    //completion(object, nil)
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
//    
//    
//    
//    func forgotPassword(email: String, completion:@escaping (Response<LoginResponse,String>) -> Void) {
//        
//        let path = basePath + auth.forgotPassword
//        
//        let params = ["email": email] as [String: Any]
//        
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: rawHeader )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//            
//                        print("ws Error: \(String(describing: response.error))")
//                        print("ws Response: \(String(describing: response.response))")
//                        if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                            print("ws Data: \(utf8Text)")
//                        }
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
//                     completion(.failure(AppConstant.error.serverIssue))
//                }
//                else {
//                    completion(.failure(error))
//                }
//            }
//            
//        }
//    }
//    
//    
//    func resetPassword(params: [String:Any], completion:@escaping (Response<LoginResponse,String>) -> Void) {
//        
//        let path = basePath + auth.resetPassword
//        
//     
//        
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
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
//
//            }
//            
//        }
//    }
//    
//    
//     //MARK:-  Social Login Integrations
//    
//    func socialLoginCheck(params:[String: Any],completion: @escaping(Response<LoginResponse,String>) -> Void) {
//        
//        let path = self.basePath + auth.socialLoginCheck
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil)
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//            
//            print("ws Error: \(String(describing: response.error))")
//            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//            
//            switch response.result {
//            case .success(_):
//                let object = response.result.value
//                if (object?.success)! {
//                     completion(.sucess(object!))
//                }
//                else {
//                    //let msg = object?.errors
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
//
//            }
//            
//        }
//        
//    }
//   
//    func socialLoginRegister(params:[String: Any],completion: @escaping(Response<LoginResponse,String>) -> Void) {
//        
//        let path = self.basePath + auth.socialLogin
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: params,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil)
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
//            
//            print("ws Error: \(String(describing: response.error))")
//            print("ws Response: \(String(describing: response.response))")
//            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
//                print("ws Data: \(utf8Text)")
//            }
//            
//            switch response.result {
//            case .success(_):
//                let object = response.result.value
//                if (object?.success)! {
//                    completion(.sucess(object!))
//                }
//                else {
//                    //let msg = object?.errors
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
//        
//    }
//    func contactUs(params:[String: Any], completion:@escaping (Response<LoginResponse, String>) -> Void){
//        
//        let path = basePath + setting.contactus
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .post,
//                                             parameters: nil,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil )
//        
//        request.responseObject { (response : DataResponse<LoginResponse>) in
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
//            
//        }
//    }
}


