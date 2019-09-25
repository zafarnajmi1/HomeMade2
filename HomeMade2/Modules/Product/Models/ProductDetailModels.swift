//
//  ProductDetailModels.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


struct AddToCartParams : Codable {
    var product: String?
    var combination: String?
    var quantity: Int?
    private enum CodingKeys: String, CodingKey {
        
        case product = "product"
        case combination = "combination"
        case quantity = "quantity"
    }
    init() {
        
    }
    init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product = try values.decodeIfPresent(String.self, forKey: .product)
        combination = try values.decodeIfPresent(String.self, forKey: .combination)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)

    }
}


class ProductDetailAPIResponse: APIResponse {
    var data : ProductDetail?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(ProductDetail.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}

class ProductDetail : Codable {
    let _id : String?
    let title : String?
    let description : String?
    let reviews : [String]?
    let categories : [Category]?
    let price : Price?
    let stock : Int?
    let minPrice : Price?
    let maxPrice : Price?
    let available : Int?
    let reserved : Int?
    let sold : Int?
//    let features : [String]?
//    let characteristics : [String]?
    let featuredPackages : [String]?
    let onlineSaleable : Bool?
    let averageRating : Int?
    let address : String?
    let location : [Double]?
    let isFeatured : Bool?
    let isActive : Bool?
    let hasCombination : Bool?
    let combinations : [Combination]?
    let store : BaseStore?
    let images : [ImageObject]?
    var priceables : [Priceables1]?
    var isFavorite : Bool?
//    let canReviewUsers : [String]?
    let createdAt : String?
    let updatedAt : String?
    let titleEn : String?
    let titleAr : String?
    let descriptionEn : String?
    let descriptionAr : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case description = "description"
        case reviews = "reviews"
        case categories = "categories"
        case price = "price"
        case stock = "stock"
        case minPrice = "minPrice"
        case maxPrice = "maxPrice"
        case available = "available"
        case reserved = "reserved"
        case sold = "sold"
//        case features = "features"
//        case characteristics = "characteristics"
        case featuredPackages = "featuredPackages"
        case onlineSaleable = "onlineSaleable"
        case averageRating = "averageRating"
        case address = "address"
        case location = "location"
        case isFeatured = "isFeatured"
        case isActive = "isActive"
        case hasCombination = "hasCombination"
        case combinations = "combinations"
        case store = "store"
        case images = "images"
        case priceables = "priceables"
        case isFavorite = "isFavorite"
//        case canReviewUsers = "canReviewUsers"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
        case descriptionEn = "descriptionEn"
        case descriptionAr = "descriptionAr"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        reviews = try values.decodeIfPresent([String].self, forKey: .reviews)
        categories = try values.decodeIfPresent([Category].self, forKey: .categories)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        stock = try values.decodeIfPresent(Int.self, forKey: .stock)
        minPrice = try values.decodeIfPresent(Price.self, forKey: .minPrice)
        maxPrice = try values.decodeIfPresent(Price.self, forKey: .maxPrice)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        reserved = try values.decodeIfPresent(Int.self, forKey: .reserved)
        sold = try values.decodeIfPresent(Int.self, forKey: .sold)
//        features = try values.decodeIfPresent([String].self, forKey: .features)
//        characteristics = try values.decodeIfPresent([String].self, forKey: .characteristics)
        featuredPackages = try values.decodeIfPresent([String].self, forKey: .featuredPackages)
        onlineSaleable = try values.decodeIfPresent(Bool.self, forKey: .onlineSaleable)
        averageRating = try values.decodeIfPresent(Int.self, forKey: .averageRating)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent([Double].self, forKey: .location)
        isFeatured = try values.decodeIfPresent(Bool.self, forKey: .isFeatured)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        hasCombination = try values.decodeIfPresent(Bool.self, forKey: .hasCombination)
        combinations = try values.decodeIfPresent([Combination].self, forKey: .combinations)
        store = try values.decodeIfPresent(BaseStore.self, forKey: .store)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        priceables = try values.decodeIfPresent([Priceables1].self, forKey: .priceables)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
//        canReviewUsers = try values.decodeIfPresent([String].self, forKey: .canReviewUsers)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        descriptionEn = try values.decodeIfPresent(String.self, forKey: .descriptionEn)
        descriptionAr = try values.decodeIfPresent(String.self, forKey: .descriptionAr)
    }
    
}


struct Characteristic : Codable {
    
    
    
    
    let _id : String?
    let title : String?
    let image : String?
    let titleEn : String?
    let titleAr : String?
    
    let combinations : [[Combination1]]?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case image = "image"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
        case combinations = "combinations"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        combinations = try values.decodeIfPresent([[Combination1]].self, forKey: .combinations)
    }
    
}

struct Feature : Codable {
    let _id : String?
    let title : String?
    let characteristics : [String]?
    let type : String?
    let sortOrder : Int?
    let titleEn : String?
    let titleAr : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case characteristics = "characteristics"
        case type = "type"
        case sortOrder = "sortOrder"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        characteristics = try values.decodeIfPresent([String].self, forKey: .characteristics)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        sortOrder = try values.decodeIfPresent(Int.self, forKey: .sortOrder)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
    }
    
}

class Priceables : Codable {
    let characteristics : [Characteristic]?
    let _id : String?
    let feature : Feature?
    
    //This key is not from server. This key is used to store the selected Option.
    var selectedIndex : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case characteristics = "characteristics"
        case _id = "_id"
        case feature = "feature"
        case selectedIndex = "selectedIndex"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        characteristics = try values.decodeIfPresent([Characteristic].self, forKey: .characteristics)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        feature = try values.decodeIfPresent(Feature.self, forKey: .feature)
        selectedIndex = try values.decodeIfPresent(Int.self, forKey: .selectedIndex)
        
        
        
    }
    
}

class Combination : Codable {
    let features : [String]?
    let characteristics : [String]?
    let price : Price?
    let available : Int?
    let _id : String?
    let images : [ImageObject]?
    
    enum CodingKeys: String, CodingKey {
        
        case features = "features"
        case characteristics = "characteristics"
        case price = "price"
        case available = "available"
        case _id = "_id"
        case images = "images"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        characteristics = try values.decodeIfPresent([String].self, forKey: .characteristics)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
    }
    
}
