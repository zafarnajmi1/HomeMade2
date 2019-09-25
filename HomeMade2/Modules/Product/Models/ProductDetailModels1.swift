//
//  ProductDetailModels.swift
//  HomeMade2
//
//  Created by Apple on 19/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


struct Priceables1 : Codable {
    var characteristics : [Characteristic]?
    let _id : String?
    let feature : Feature?
    var selectedIndex : Int?
    enum CodingKeys: String, CodingKey {
        
        case characteristics = "characteristics"
        case _id = "_id"
        case feature = "feature"
        case selectedIndex = "selectedIndex"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        characteristics = try values.decodeIfPresent([Characteristic].self, forKey: .characteristics)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        feature = try values.decodeIfPresent(Feature.self, forKey: .feature)
        selectedIndex = try values.decodeIfPresent(Int.self, forKey: .selectedIndex)
    }
    
}
struct Characteristic1 : Codable {
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

struct Combination1 : Codable {
    let _id : String?
    let title : String?
    let feature : String?
    let titleEn : String?
    let titleAr : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case feature = "feature"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        feature = try values.decodeIfPresent(String.self, forKey: .feature)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
    }
    
}
struct Feature1 : Codable {
    let _id : String?
    let sortOrder : Int?
    let title : String?
    let titleAr : String?
    let titleEn : String?
    let type : String?
    let characteristics : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case sortOrder = "sortOrder"
        case title = "title"
        case titleAr = "titleAr"
        case titleEn = "titleEn"
        case type = "type"
        case characteristics = "characteristics"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        sortOrder = try values.decodeIfPresent(Int.self, forKey: .sortOrder)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        characteristics = try values.decodeIfPresent([String].self, forKey: .characteristics)
    }
    
}
