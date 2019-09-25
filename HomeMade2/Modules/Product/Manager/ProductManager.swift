//
//  ProductManager.swift
//  HomeMade2
//
//  Created by Apple on 21/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ProductManager: RequestManager {
    
    func productDetail(productID : String, completionHandler: @escaping (ProductDetailAPIResponse?, String?) -> Void){
        let params = ["_id": productID]
        
        
        print("Parameters :\(params)")
        let url = PRODUCT_DETAILS
        
        print("Fetch Products Details:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Fetch ProductDetail Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(ProductDetailAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Fetch ProductDetail Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func favoriteProduct(productID : String, completionHandler: @escaping (APIResponse?, String?) -> Void){
        let params = ["_id": productID]
        
        
        print("Parameters :\(params)")
        let url = FAVORITE_PRODUCT
        
        print("Favorite Product URL:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Favorite Product Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Favorite Product Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func addToCart(parameters : AddToCartParams, completionHandler: @escaping (APIResponse?, String?) -> Void){
        
         let params = parameters.dictionary
        
        print("Parameters :\(params ?? [:])")
        let url = ADD_TO_CART
        
        print("Add Item to Cart:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Add Item to Cart Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Add Item to Cart Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func updateCart(parameters : AddToCartParams, completionHandler: @escaping (APIResponse?, String?) -> Void){
        
        let params = parameters.dictionary
        
        print("Parameters :\(params ?? [:])")
        let url = UPDATE_CART
        
        print("Update Item in Cart:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Update Item in Cart Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Update Item in Cart Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    
    func removeFromCart(itemID : String, completionHandler: @escaping (APIResponse?, String?) -> Void){
        
        let params = ["product":itemID]
        
        print("Parameters :\(params)")
        let url = REMOVE_FROM_CART
        
        print("Remove Item from Cart:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Remove Item from Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Remove Item from Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func getMyCart(completionHandler: @escaping (CartAPIResponse?, String?) -> Void){
        
//        let params = parameters.dictionary
        
//        print("Parameters :\(params ?? [:])")
        let url = GET_CART
        
        print("GET MY Cart:\(url)")
        
        self.request(url, method: .get, parameters: nil) { (response) in
            print("Add Item to Cart Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(CartAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Add Item to Cart Failed :\(error)")
                    let error = "Something went wrong, please try again later".localized
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }

}
