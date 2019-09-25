//
//  SettingManager.swift
//  TailerOnline
//
//  Created by apple on 4/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class SettingManger: RequestManager {
    
//    static let shared = SettingManger()
//
    
    func fetchSettings(completionHandler: @escaping (SettingAPIResponse?, String?) -> Void){
        
 
        let url = GET_SETTINGS
        
        print("Fetch Settings:\(url)")
        
        self.request(url, method: .get, parameters: nil) { (response) in
            print("Fetch Settings Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(SettingAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Fetch Settings in Cart Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    
//    func fetchSettings(completion: @escaping (Response<SettingAPIResponse,String>) -> Void) {
//
//        let path = basePath + setting.settings
//        // make calls with the session manager
//        let request = sessionManager.request(path,
//                                             method: .get,
//                                             parameters: nil,
//                                             encoding: JSONEncoding.default,
//                                             headers: nil )
//
////        request.responseObject { (response : DataResponse<SettingAPIResponse>) in
////
////            print("ws Error: \(String(describing: response.error))")
////            print("ws Response: \(String(describing: response.response))")
////            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
////                print("ws Data: \(utf8Text)")
////            }
////
////            switch response.result {
////            case .success(_):
////
////                let object = response.result.value
////
////                if (object?.success)! {
////                    completion(.sucess(object!))
////                }
////                else {
////                    let error = object?.message
////                    completion(.failure(error!))
////                }
////
////
////            case .failure(let error):
////                let error = error.localizedDescription
////                if error.contains(AppConstant.error.objectMapper) {
////                    completion(.failure(AppConstant.error.serverIssue))
////                }
////                else {
////                    completion(.failure(error))
////                }
////            }
////
////
////        }
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
