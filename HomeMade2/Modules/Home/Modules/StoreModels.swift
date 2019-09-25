//
//  StoreModels.swift
//  HomeMade2
//
//  Created by Apple on 03/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleMaps
class StoreListRequestParams: Codable {
    var page : Int?
    var skip : Int?
    var pagination : String?
    var latitude : Double?
    var longitude : Double?
    var storeName : String?
    var location : [Double]?
}
class StoreMapRequestParams: Codable {
//    var page : Int?
//    var pagination : String?
    var latitude : Double?
    var longitude : Double?
    var storeName : String?
    var location : [Double]?
    var isNear : Bool = true
}

class StoresListAPIResponse: APIResponse {
    var data : [ListStore]?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent([ListStore].self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
class ListStore : Codable {
    let _id : String?
    let storeName : String?
    let address : String?
    let location : [Double]?
    let averageRating : Double?
    let image : String?
    let storeNameEn : String?
    let storeNameAr : String?
    let distance : Double?
    var marker : GMSMarker?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case storeName = "storeName"
        case address = "address"
        case location = "location"
        case averageRating = "averageRating"
        case image = "image"
        case storeNameEn = "storeNameEn"
        case storeNameAr = "storeNameAr"
        case distance = "distance"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent([Double].self, forKey: .location)
        averageRating = try values.decodeIfPresent(Double.self, forKey: .averageRating)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
    }
    
}

