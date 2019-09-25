//
//  OrderManager.swift
//  HomeMadeSuppliers
//
//  Created by apple on 6/20/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class HomeManager: RequestManager {

    func getStoresList( params: StoreListRequestParams , completionHandler: @escaping (StoresListAPIResponse?, String?) -> Void){
        
        let params = params.dictionary
        
        print("Parameters :\(params ?? [:])")
        let url = STORES_LIST
        
        print("GET STORES LIST:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("GET STORES LIST Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(StoresListAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("GET STORES LIST Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func getMapStoresList( params: StoreMapRequestParams , completionHandler: @escaping (StoresListAPIResponse?, String?) -> Void){
        
        let params = params.dictionary
        
        print("Parameters :\(params ?? [:])")
        let url = STORES_LIST_MAP
        
        print("GET STORES MAP LIST:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("GET STORES MAP Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(StoresListAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("GET STORES MAP Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func getStoreDetail( id: String , completionHandler: @escaping (StoreDetailAPIResponse?, String?) -> Void){
        
        let params = ["_id":id]
        
        print("Parameters :\(params)")
        let url = STORES_DETAILS
        
        print("GET STORES DETAILS:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("GET STORES DETAILS Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(StoreDetailAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("GET STORES DETAILS Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func getStoreReviews(skip : Int = 0,  id: String , completionHandler: @escaping (StoreReviewsAPIResponse?, String?) -> Void){
        
        let params = ["store":id,
                      "skip":skip] as [String : Any]
        
        print("Parameters :\(params)")
        let url = STORE_REVIEWS
        
        print("GET STORE REVIEWS:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("GET STORE REVIEWS Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(StoreReviewsAPIResponse.self, from: response.data!)
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
    func writeReviewForStore(review : Review, completionHandler: @escaping (WriteStoreReviewsAPIResponse?, String?) -> Void){
        
        

        var params = review.dictionary
        
        params?.updateValue("\(review.rating)", forKey: "rating")
        print("Parameters :\(params ?? [:])")
        let url = SUBMIT_REVIEWS
        
        print("Write Review STORE REVIEWS:\(url)")
        
        self.request(url, method: .post, parameters: params) { (response) in
            print("Write Review STORE Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(WriteStoreReviewsAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("Write Review STORE Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }
    func getStoreProducts( id: String , completionHandler: @escaping (StoreProductsAPIResponse?, String?) -> Void){
        
        let params = ["store":id]
        
        print("Parameters :\(params)")
        let url = FAVORITE_PRODUCT
        
        print("STORE PRODUCTS URL:\(url)")
        self.request(url, method: .post, parameters: params) { (response) in
            print("STORE PRODUCTS Response :\(response)")
            
            if let error = self.checkError(Response: response){
                completionHandler (nil, error)
            }
            else{
                do {
                    let apiResponse = try JSONDecoder().decode(StoreProductsAPIResponse.self, from: response.data!)
                    completionHandler(apiResponse, nil)
                }
                catch let error {
                    print("STORE PRODUCTS Failed :\(error)")
                    let error = self.parsingError
                    completionHandler(nil, error)
                }
                
                
            }
        }
    }

    
    
////    func checkout( params: [String: Any] , completion:@escaping (Response<UserLoginAPIResponse,String>) -> Void) {
//
////        let path = basePath + order.authCheckout
//
//    func checkout( params: [String: Any] , completionHandler: @escaping (APIResponse?, String?) -> Void){
//        
//        //        let params = parameters.dictionary
//        
//        print("Parameters :\(params)")
//        let url = PAYMENT
//        
//        print("CHECKOUT in Cart:\(url)")
//        
//        self.request(url, method: .post, parameters: params) { (response) in
//            print("CHECKOUT Cart Response :\(response)")
//            
//            if let error = self.checkError(Response: response){
//                completionHandler (nil, error)
//            }
//            else{
//                do {
//                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
//                    completionHandler(apiResponse, nil)
//                }
//                catch let error {
//                    print("CHECKOUT Cart Failed :\(error)")
//                    let error = "Something went wrong, please try again later".localized
//                    completionHandler(nil, error)
//                }
//                
//                
//            }
//        }
//    }
//
//    
////    func fetchBuyerOrders( params:[String:Any] ,completion:@escaping (Response<OrderAPIResponse,String>) -> Void) {
////
////
////        let path = basePath + order.authOrdersUsers
//        func fetchBuyerOrders( params: [String: Any] , completionHandler: @escaping (BuyerOrdersAPIResponse?, String?) -> Void){
//            
//            //        let params = parameters.dictionary
//            
//            print("Parameters :\(params)")
//            let url = USER_ORDERS
//            
//            print("Update Item in Cart:\(url)")
//            
//            self.request(url, method: .post, parameters: params) { (response) in
//                print("Update Item in Cart Response :\(response)")
//                
//                if let error = self.checkError(Response: response){
//                    completionHandler (nil, error)
//                }
//                else{
//                    do {
//                        let apiResponse = try JSONDecoder().decode(BuyerOrdersAPIResponse.self, from: response.data!)
//                        completionHandler(apiResponse, nil)
//                    }
//                    catch let error {
//                        print("Update Item in Cart Failed :\(error)")
//                        let error = "Something went wrong, please try again later".localized
//                        completionHandler(nil, error)
//                    }
//                    
//                    
//                }
//            }
//        }
//    func fetchSellerOrders( params: [String: Any] , completionHandler: @escaping (SellerOrdersAPIResponse?, String?) -> Void){
//        
//        //        let params = parameters.dictionary
//        
//        print("Parameters :\(params)")
//        let url = USER_ORDERS
//        
//        print("Seller Orders URL:\(url)")
//        
//        self.request(url, method: .post, parameters: params) { (response) in
//            print("Seller Orders Response :\(response)")
//            
//            if let error = self.checkError(Response: response){
//                completionHandler (nil, error)
//            }
//            else{
//                do {
//                    let apiResponse = try JSONDecoder().decode(SellerOrdersAPIResponse.self, from: response.data!)
//                    completionHandler(apiResponse, nil)
//                }
//                catch let error {
//                    print("Seller Orders Failed :\(error)")
//                    let error = "Something went wrong, please try again later".localized
//                    completionHandler(nil, error)
//                }
//                
//                
//            }
//        }
//    }
//
//
//    //
////    func fetchSellerOrders( params:[String:Any] ,completion:@escaping (Response<OrderAPIResponse,String>) -> Void) {
////
////
////        let path = basePath + order.authOrdersStores
//    
//        // make calls with the session manager
////        func fetchSellerOrders( params: [String: Any] , completionHandler: @escaping (APIResponse?, String?) -> Void){
////
////
////
////            print("Parameters :\(params)")
////            let url = STORE_ORDERS
////
////            print("Update Item in Cart:\(url)")
////
////            self.request(url, method: .post, parameters: params) { (response) in
////                print("Update Item in Cart Response :\(response)")
////
////                if let error = self.checkError(Response: response){
////                    completionHandler (nil, error)
////                }
////                else{
////                    do {
////                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
////                        completionHandler(apiResponse, nil)
////                    }
////                    catch let error {
////                        print("Update Item in Cart Failed :\(error)")
////                        let error = "Something went wrong, please try again later".localized
////                        completionHandler(nil, error)
////                    }
////
////
////                }
////            }
////        }
//
//
////    func shipProductByOrderDetail(id: String ,completion:@escaping (Response<OrderAPIResponse,String>) -> Void) {
////
////        let params:[String:Any] = ["orderDetailId": id]
////
////        let path = basePath + order.authShipProduct
//
//        func shipProductByOrderDetail( id: String , completionHandler: @escaping (APIResponse?, String?) -> Void){
//            
//            
//            let params:[String:Any] = ["orderDetailId": id]
//            print("Parameters :\(params)")
//            let url = SHIP_PRODUCT
//            
//            print("Update Item in Cart:\(url)")
//            
//            self.request(url, method: .post, parameters: params) { (response) in
//                print("Update Item in Cart Response :\(response)")
//                
//                if let error = self.checkError(Response: response){
//                    completionHandler (nil, error)
//                }
//                else{
//                    do {
//                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
//                        completionHandler(apiResponse, nil)
//                    }
//                    catch let error {
//                        print("Update Item in Cart Failed :\(error)")
//                        let error = "Something went wrong, please try again later".localized
//                        completionHandler(nil, error)
//                    }
//                    
//                    
//                }
//            }
//        }
////
////    func completeProductByOrderDetail(id: String ,completion:@escaping (Response<OrderAPIResponse,String>) -> Void) {
////
////        let params:[String:Any] = ["orderDetailId": id]
////
////        let path = basePath + order.authCompleteProduct
//
//        func completeProductByOrderDetail( id: String , completionHandler: @escaping (APIResponse?, String?) -> Void){
//            
//            
//            let params:[String:Any] = ["orderDetailId": id]
//            print("Parameters :\(params)")
//            let url = COMPLETE_PRODUCT
//            
//            print("Update Item in Cart:\(url)")
//            
//            self.request(url, method: .post, parameters: params) { (response) in
//                print("Update Item in Cart Response :\(response)")
//                
//                if let error = self.checkError(Response: response){
//                    completionHandler (nil, error)
//                }
//                else{
//                    do {
//                        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
//                        completionHandler(apiResponse, nil)
//                    }
//                    catch let error {
//                        print("Update Item in Cart Failed :\(error)")
//                        let error = "Something went wrong, please try again later".localized
//                        completionHandler(nil, error)
//                    }
//                    
//                    
//                }
//            }
//        }
////
////    func orderDetail(id: String ,completion:@escaping (Response<OrderDetailAPIResponse,String>) -> Void) {
////
////        let params:[String:Any] = ["_id": id]
////
////        let path = basePath + order.authOrderDetail
//
//        // make calls with the session manager
//    func buyerOrderDetail( id: String , completionHandler: @escaping (BuyerOrderDetailAPIResponse?, String?) -> Void){
//        
//        
//        let params:[String:Any] = ["_id": id]
//        print("Parameters :\(params)")
//        let url = ORDER_DETAIL
//        
//        print("Buyer Order Detail Url:\(url)")
//        
//        self.request(url, method: .post, parameters: params) { (response) in
//            print("Buyer Order Detail Response :\(response)")
//            
//            if let error = self.checkError(Response: response){
//                completionHandler (nil, error)
//            }
//            else{
//                do {
//                    let apiResponse = try JSONDecoder().decode(BuyerOrderDetailAPIResponse.self, from: response.data!)
//                    completionHandler(apiResponse, nil)
//                }
//                catch let error {
//                    print("Buyer Order Detail Failed :\(error)")
//                    let error = "Something went wrong, please try again later".localized
//                    completionHandler(nil, error)
//                }
//                
//                
//            }
//        }
//    }
////
////    func orderStoreDetail(id: String ,completion:@escaping (Response<StoreOrderDetailAPIResponse,String>) -> Void) {
////
////        let params:[String:Any] = ["_id": id]
////
////        let path = basePath + order.authOrdersStoresDetail
//
//        // make calls with the session manager
//    func orderStoreDetail( id: String , completionHandler: @escaping (APIResponse?, String?) -> Void){
//        
//        
//        let params:[String:Any] = ["orderDetailId": id]
//        print("Parameters :\(params)")
//        let url = ORDER_STORE_DETAIL
//        
//        print("Update Item in Cart:\(url)")
//        
//        self.request(url, method: .post, parameters: params) { (response) in
//            print("Update Item in Cart Response :\(response)")
//            
//            if let error = self.checkError(Response: response){
//                completionHandler (nil, error)
//            }
//            else{
//                do {
//                    let apiResponse = try JSONDecoder().decode(APIResponse.self, from: response.data!)
//                    completionHandler(apiResponse, nil)
//                }
//                catch let error {
//                    print("Update Item in Cart Failed :\(error)")
//                    let error = "Something went wrong, please try again later".localized
//                    completionHandler(nil, error)
//                }
//                
//                
//            }
//        }
//    }
}

