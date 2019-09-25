//
//  RequestManager.swift
//  HomeMade2
//
//  Created by Apple on 14/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//


import UIKit
import Alamofire
//import SwiftyJSON
import MBProgressHUD

enum ErrorCode : Int {
    case parsingError = 10
    case unknown = -1
}


class RequestManager {
    
    var parsingError : String{
        get {
            return "Something went wrong, please try again later".localized
        }
    }
    var HEADERS : HTTPHeaders  {
        get {
            guard  let authId = AppSettings.shared.loggedInUser?.authorization  else {
                return ["Authorization": ""]
            }
            return ["Authorization": authId]
        }
        
    }
    
    var progressHUD : MBProgressHUD!
    var roundProgress : MBRoundProgressView!
    
    
    func showProgress(){
        
        guard let view = UIApplication.shared.delegate?.window as? UIView else{
            return
        }
//        let window = UIApplication.shared.delegate?.window
        progressHUD = MBProgressHUD(view: view)
        progressHUD.mode = .customView
        
        //        MBRoundProgressView(frame: (0,0,37,37))
        let rect = CGRect(x: 0, y: 0, width: 37, height: 37)
        roundProgress  = MBRoundProgressView(frame: rect)
        roundProgress.progress = 0.0
        roundProgress.isAnnular = true
        //        roundProgress.progressTintColor
        roundProgress.backgroundTintColor = UIColor.gray
        progressHUD.customView = roundProgress
    }
    func hideProgress(){
        progressHUD.hide(animated: true)
    }
    
    public func request(
        _ url: URLConvertible,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        completionHandler: @escaping (DataResponse<Any>) -> Void)
    {
        
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.prettyPrinted, headers: HEADERS).responseJSON { (response) in
            completionHandler(response)
        }
    }
    
    public func multiPartRequest(
        _ picture: UIImage!,
        _ url: String,
        method: HTTPMethod,
        parameters: Parameters,
        completionHandler: @escaping (DataResponse<Any>) -> Void,
        progressHandler: @escaping (_ progress : Double) -> Void)
    {
        
        let url = try! URLRequest(url: URL(string:url)!, method: method, headers: HEADERS)
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if picture != nil
                {
                    
                    if let data = picture.jpegData(compressionQuality: 0.5){
                        multipartFormData.append(data, withName: "MediaFile", fileName: "file.png", mimeType: "image/jpeg")
                    }
                    
                    
                }
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    //                    multipartFormData.append((value as! String).data(using: .utf8)!, withName: key)
                }
                
        },
            with: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //                        if((response.result.value) != nil) {
                        completionHandler(response)
                        //                        } else {
                        //
                        //                        }
                    }
                    upload.uploadProgress{ progress in
                        
                        progressHandler(progress.fractionCompleted)
                        print(progress.fractionCompleted)
                        
                    }
                case .failure( _):
                    break
                }
        }
        )
        
    }
    public func multiPartRequest(
        _ data: Data!,
        _ type: String,
        _ url: String,
        mediaFile : String = "MediaFile",
        method: HTTPMethod,
        parameters: Parameters,
        completionHandler: @escaping (DataResponse<Any>) -> Void,
        progressHandler: @escaping (_ progress : Double) -> Void)
    {
        
        let url = try! URLRequest(url: URL(string:url)!, method: method, headers: HEADERS)
        
        print("Parameters :\(parameters)")
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if data != nil
                {
                    if type == "Photo"{
                        
                        multipartFormData.append(data, withName: mediaFile, fileName: "file.png", mimeType: "image/jpeg")
                    }
                    else if type == "Video"{
                        multipartFormData.append(data, withName: mediaFile, fileName: "file.mp4", mimeType: "video/mp4")
                    }
                    
                }
                
                for (key, value) in parameters {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                    //                    multipartFormData.append((value as! String).data  `(using: .utf8)!, withName: key)
                }
                
        },
            with: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        //                        if((response.result.value) != nil) {
                        completionHandler(response)
                        //                        } else {
                        //
                        //                        }
                    }
                    upload.uploadProgress{ progress in
                        
                        progressHandler(progress.fractionCompleted)
                        print(progress.fractionCompleted)
                        
                    }
                case .failure( _):
                    break
                }
        }
        )
        
    }
    
    

    public func checkError(Response: DataResponse<Any>) -> String?
    {
        
        if Response.error != nil {
            

            
//            if Response.response == nil{
//                let error = HMSError(errorCode: 1000, errorMessage: (Response.error?.localizedDescription)!)
                return Response.error?.localizedDescription
//            }
//            else{
//                let error = HMSError(errorCode: (Response.response?.statusCode)!, errorMessage: (Response.error?.localizedDescription)!)
//                return error
//            }
            
            
        }
        else{
            return nil
        }
        
        
    }
    
    
}

