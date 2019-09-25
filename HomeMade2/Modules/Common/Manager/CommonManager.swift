//
//  CommonManager.swift
//  HomeMade2
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import Alamofire


class CommonManager: RequestManager {
    
    func fetchAddress(latitude : Double, longitude : Double, completionHandler: @escaping (GoogleAddressAPIResponse?, String?) -> Void){
//        let key = AppDelegate.
        
        let URL = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(latitude),\(longitude)&key=\(GOOGLE_API_KEY)"
        
        Alamofire.request(URL, method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON { (response) in

                    print("GET STORES MAP Response :\(response)")
                    
//                    if let error = self.checkError(Response: response){
//                        completionHandler (nil, error)
//                    }
//                    else{
                        do {
                            let apiResponse = try JSONDecoder().decode(GoogleAddressAPIResponse.self, from: response.data!)
                            
                            if apiResponse.status == "OK"{
                                completionHandler(apiResponse, nil)
                            }
                            else{
                                completionHandler(apiResponse, apiResponse.status)
                            }
                        }
                        catch let error {
                            print("GET STORES MAP Failed :\(error)")
                            let error = "Something went wrong, please try again later".localized
                            completionHandler(nil, error)
                        }

        }
    }

}



