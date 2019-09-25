//
//  StoreDetailModel.swift
//  HomeMade2
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class StoreDetailAPIResponse : APIResponse {
    let data : StoreDetail?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(StoreDetail.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}

struct StoreDetail : Codable {
    let _id : String?
    let storeName : String?
    let description : String?
    let address : String?
    let location : [Double]?
    let averageRating : Double?
    let image : String?
    let isActive : Bool?
    let descriptionEn : String?
    let descriptionAr : String?
    let storeNameEn : String?
    let storeNameAr : String?
    let distance : Double?
    let canReviewUsers : [OrderForReview]?
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case storeName = "storeName"
        case description = "description"
        case address = "address"
        case location = "location"
        case averageRating = "averageRating"
        case image = "image"
        case isActive = "isActive"
        case descriptionEn = "descriptionEn"
        case descriptionAr = "descriptionAr"
        case storeNameEn = "storeNameEn"
        case storeNameAr = "storeNameAr"
        case distance = "distance"
        case canReviewUsers = "canReviewUsers"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent([Double].self, forKey: .location)
        averageRating = try values.decodeIfPresent(Double.self, forKey: .averageRating)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        descriptionEn = try values.decodeIfPresent(String.self, forKey: .descriptionEn)
        descriptionAr = try values.decodeIfPresent(String.self, forKey: .descriptionAr)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
        canReviewUsers = try values.decodeIfPresent([OrderForReview].self, forKey: .canReviewUsers)
    }
    
}

struct OrderForReview : Codable {
    
    let _id : String?
    let order : String?
    let orderDetail : String?
    let user : String?
    let product : String?
    let store : String?
    let combination : String?
    enum CodingKeys: String, CodingKey {
        
        
        case _id = "_id"
        case order = "order"
        case orderDetail = "orderDetail"
        case user = "user"
        case product = "product"
        case store = "store"
        case combination = "combination"
        
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        order = try values.decodeIfPresent(String.self, forKey: .order)
        orderDetail = try values.decodeIfPresent(String.self, forKey: .orderDetail)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        product = try values.decodeIfPresent(String.self, forKey: .product)
        store = try values.decodeIfPresent(String.self, forKey: .store)
        combination = try values.decodeIfPresent(String.self, forKey: .combination)
        
    }
    
}


class StoreProductsAPIResponse : APIResponse {

    let data : [StoreProduct]?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([StoreProduct].self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
struct StoreProduct : Codable {
    let _id : String?
    let title : String?
    let categories : [String]?
    let price : Price?
    let available : Int?
    let averageRating : Double?
    let address : String?
    let hasCombination : Bool?
    let store : User?
    let titleEn : String?
    let titleAr : String?
    let isFavorite : Bool?
    let features : [String]?
    let images : [String]?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case categories = "categories"
        case price = "price"
        case available = "available"
        case averageRating = "averageRating"
        case address = "address"
        case hasCombination = "hasCombination"
        case store = "store"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
        case isFavorite = "isFavorite"
        case features = "features"
        case images = "images"
        case image = "image"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        averageRating = try values.decodeIfPresent(Double.self, forKey: .averageRating)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        hasCombination = try values.decodeIfPresent(Bool.self, forKey: .hasCombination)
        store = try values.decodeIfPresent(User.self, forKey: .store)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
        features = try values.decodeIfPresent([String].self, forKey: .features)
        images = try values.decodeIfPresent([String].self, forKey: .images)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}


class StoreReviewsAPIResponse : APIResponse {
    let data : [StoreReview]?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([StoreReview].self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
struct StoreReview : Codable {
    let _id : String?
    let rating : Double?
    let comment : String?
    let user : ReviewUser?
    let store : ReviewStore?
    let createdAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case rating = "rating"
        case comment = "comment"
        case user = "user"
        case store = "store"
        case createdAt = "createdAt"
    }
    
    init(_id : String?, rating : Double?, comment : String?, user : ReviewUser?, store : ReviewStore?, createdAt : String?) {
        self._id = _id
        self.rating = rating
        self.createdAt = createdAt
        self.comment = comment
        self.user = user
        self.store = store
        
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        comment = try values.decodeIfPresent(String.self, forKey: .comment)
        user = try values.decodeIfPresent(ReviewUser.self, forKey: .user)
        store = try values.decodeIfPresent(ReviewStore.self, forKey: .store)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}

struct ReviewStore : Codable {
    let _id : String?
    let storeName : String?
    let averageRating : Double?
    let storeNameEn : String?
    let storeNameAr : String?
    
    
    init(_id : String?,storeName : String?,averageRating : Double?,storeNameEn : String?, storeNameAr: String?) {
        self._id = _id
        self.storeName = storeName
        self.averageRating = averageRating
        self.storeNameEn = storeNameEn
        self.storeNameAr = storeNameAr
    }
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case storeName = "storeName"
        case averageRating = "averageRating"
        case storeNameEn = "storeNameEn"
        case storeNameAr = "storeNameAr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        averageRating = try values.decodeIfPresent(Double.self, forKey: .averageRating)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
    }
    
}
struct ReviewUser : Codable {
    let _id : String?
    let image : String?
    let firstName : String?
    let lastName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case image = "image"
        case firstName = "firstName"
        case lastName = "lastName"
    }
    
    init(_id : String?,image : String?,firstName : String?,lastName : String?) {
        self._id = _id
        self.image = image
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }
    
}


class WriteStoreReviewsAPIResponse : APIResponse {
    let data : OrderForReview?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(OrderForReview.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
