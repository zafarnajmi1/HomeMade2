//
//  SellerModels.swift
//  HomeMade2
//
//  Created by Apple on 02/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class SellerOrdersAPIResponse: APIResponse {
    var data : [SellerOrder]?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent([SellerOrder].self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}

class SellerOrder : Codable {
    let _id : String?
    let price : Price?
    let total : Price?
    let quantity : Int?
    var status : String?
    let order : Order?
    let product : OrderProduct?
    let store : User?
    let combinationDetail : [OrderCombination]?
    let images : [ImageObject]?
    let createdAt : String?
    let updatedAt : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case price = "price"
        case total = "total"
        case quantity = "quantity"
        case status = "status"
        case order = "order"
        case product = "product"
        case store = "store"
        case combinationDetail = "combinationDetail"
        case images = "images"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        total = try values.decodeIfPresent(Price.self, forKey: .total)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        order = try values.decodeIfPresent(Order.self, forKey: .order)
        product = try values.decodeIfPresent(OrderProduct.self, forKey: .product)
        store = try values.decodeIfPresent(User.self, forKey: .store)
        combinationDetail = try values.decodeIfPresent([OrderCombination].self, forKey: .combinationDetail)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
struct Order : Codable {
    let _id : String?
    let paymentMethod : String?
    let orderNote : String?
    let user : BuyerUser?
    let addresses : [Addresse]?
    let createdAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case paymentMethod = "paymentMethod"
        case orderNote = "orderNote"
        case user = "user"
        case addresses = "addresses"
        case createdAt = "createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        orderNote = try values.decodeIfPresent(String.self, forKey: .orderNote)
        user = try values.decodeIfPresent(BuyerUser.self, forKey: .user)
        addresses = try values.decodeIfPresent([Addresse].self, forKey: .addresses)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}
struct BuyerUser : Codable {
    let _id : String?
    let phone : String?
    let address : String?
    let gender : String?
    let image : String?
    let firstName : String?
    let lastName : String?
    let email : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case phone = "phone"
        case address = "address"
        case gender = "gender"
        case image = "image"
        case firstName = "firstName"
        case lastName = "lastName"
        case email = "email"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }
    
}
