//
//  CartModels.swift
//  HomeMade2
//
//  Created by Apple on 21/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class CartAPIResponse : APIResponse {
    var data : CartObject?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(CartObject.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
class CartObject : Codable {
    let grandTotal : Price?
    let cartItems : [CartItem]?
    
    enum CodingKeys: String, CodingKey {
        
        case grandTotal = "grandTotal"
        case cartItems = "cartItems"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        grandTotal = try values.decodeIfPresent(Price.self, forKey: .grandTotal)
        cartItems = try values.decodeIfPresent([CartItem].self, forKey: .cartItems)
    }
    
}

struct CartCombination : Codable {
    var available : Int?
    var _id : String?
    private enum CodingKeys: String, CodingKey {
        case available = "available"
        case _id = "_id"
    }
    init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        available = try containter.decodeIfPresent(Int.self, forKey: .available)
        _id = try containter.decodeIfPresent(String.self, forKey: ._id)

    }
    
}
//class CartProduct : Codable {
//    var combinations : [CartCombination]?
//    private enum CodingKeys: String, CodingKey {
//        case combinations = "combinations"
//    }
//    required init(from decoder: Decoder) throws {
//        let containter = try decoder.container(keyedBy: CodingKeys.self)
//        combinations = try containter.decodeIfPresent([CartCombination].self, forKey: .combinations)
//    }
//}
class CartProduct : BaseProduct {
    var combinations : [CartCombination]?
    private enum CodingKeys: String, CodingKey {
        case combinations = "combinations"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        combinations = try containter.decodeIfPresent([CartCombination].self, forKey: .combinations)
        try super.init(from: decoder)
        
    }

}

class CartItem : Codable {
    let _id : String?
    let quantity : Int?
    let price : Price?
    let total : Price?
    let product : CartProduct?
    let store : String?
    let combinationDetail : [Priceables]?
    let images : [ImageObject]?
    let combination : String?
    let createdAt : String?
    let updatedAt : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case quantity = "quantity"
        case price = "price"
        case total = "total"
        case product = "product"
        case store = "store"
        case combinationDetail = "combinationDetail"
        case images = "images"
        case combination = "combination"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        total = try values.decodeIfPresent(Price.self, forKey: .total)
        product = try values.decodeIfPresent(CartProduct.self, forKey: .product)
        store = try values.decodeIfPresent(String.self, forKey: .store)
        combinationDetail = try values.decodeIfPresent([Priceables].self, forKey: .combinationDetail)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        combination = try values.decodeIfPresent(String.self, forKey: .combination)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}



