//
//  CategoryManager.swift
//  HomeMade2
//
//  Created by Apple on 13/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CategoryManager: RequestManager {
    
  
    func fetchCategories(completionHandler: @escaping (CategoryAPIResponse?, String?) -> Void){
        
        
        let url = FETCH_CATEGORIES
        
        print("Fetch Categories URL :\(url)")
        
        self.request(url, method: .get, parameters: nil) { (response) in
            print("Fetch Categories Response :\(response)")
            
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(CategoryAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Fetch Categories Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func searchItems(params : SearchProductsRequest, completionHandler: @escaping (ProductListAPIResponse?, String?) -> Void){
        
        let parameters = params.dictionary
        print("Parameters :\(parameters ?? [:])")
        let url = SEARCH_ITEMS
        
        print("Fetch Products List:\(url)")
        
        self.request(url, method: .post, parameters: parameters) { (response) in
            print("Fetch Products Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(ProductListAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Fetch Product Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func fetchFilterStores(completionHandler: @escaping (FilterStoreAPIResponse?, String?) -> Void){
        
        
        let url = FILTER_STORES
        
        print("Fetch Filter Stores URL :\(url)")
        
        self.request(url, method: .get, parameters: nil) { (response) in
            print("Fetch Filter Stores Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(FilterStoreAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Fetch Product Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    

}
