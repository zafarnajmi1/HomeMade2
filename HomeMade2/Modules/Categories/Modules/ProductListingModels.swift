//
//  ProductListingModels.swift
//  HomeMade2
//
//  Created by Apple on 17/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
class SearchProductsRequest : Codable {
    
    var location : [Double]?
    var characteristics : [String]?
    var keyword : String?
    var minPrice : Int?
    var maxPrice : Int?
    var categories : [String]?
    var type : String?
    var store : String?
    var isFeatured : Bool?
    var skip : Int?
    var pagination : Int?
    var isUpdated : Bool?
    var isFavorite : Bool?

}

class APIResponse : Codable {
    let success : Bool?
    let message : String?
    //    let data : [Product]?
    let errors : [String:String]?
    
    private enum CodingKeys: String, CodingKey {
        
        case success = "success"
        case message = "message"
        //        case data = "data"
        case errors = "errors"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        //        data = try values.decodeIfPresent([Product].self, forKey: .data)
        errors = try values.decodeIfPresent(Dictionary.self, forKey: .errors)
    }
    static func decode<T>(data : Data, modelType: T.Type) -> (T?,String?) where T : Decodable {
        do {
            let apiResponse = try JSONDecoder().decode(self, from: data)
            return (apiResponse as? T, nil)
            
        }
        catch {
            return (nil, "")
        }
        

    }
    static func decode<T>(dictionary : [String : Any],modelType: T.Type) -> (T?,String?) where T : Decodable {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            return decode(data: jsonData, modelType: self) as! (T?, String?)
            
        }
        catch {
            return (nil, "")
        }

        
//        do {
//            let apiResponse = try JSONDecoder().decode(modelType, from: data)
//            return apiResponse
//
//        }
//        catch let error {
//            return nil
//        }
    }
//    func aaaaa<T>(dictionary : [String : Any]) -> T
//    {
//
//        return storyboard.instantiateViewController(withIdentifier: self.className) as! T
//
//    }
//    func aaaab<T>(data : Data) -> T
//    {
//
//
//        do {
//            let apiResponse = try JSONDecoder().decode(T, from: data)
////            completionHandler(apiResponse, nil)
//        }
//        catch let error {
//            print("STORE PRODUCTS Failed :\(error)")
////            let error = self.parsingError
////            completionHandler(nil, error)
//        }
//
//
//
//    }
    
    
}
class ProductListAPIResponse : APIResponse {
    var data : [BaseProduct]?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent([BaseProduct].self, forKey: .data)
//        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}

class BaseProduct : Codable {
    let _id : String?
    let title : String?
    let categories : [String]?
    let price : Price?
    let available : Int?
    let averageRating : Double?
    let address : String?
    let store : BaseStore?
    let images : [ImageObject]?
    let titleEn : String?
    let titleAr : String?
    let features : [Features]?
    let image : String?
    let hasCombination : Bool?
    var isFavorite : Bool?
    
    private enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case categories = "categories"
        case price = "price"
        case available = "available"
        case averageRating = "averageRating"
        case address = "address"
        case store = "store"
        case images = "images"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
        case features = "features"
        case image = "image"
        case hasCombination = "hasCombination"
        case isFavorite = "isFavorite"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        available = try values.decodeIfPresent(Int.self, forKey: .available)
        averageRating = try values.decodeIfPresent(Double.self, forKey: .averageRating)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        store = try values.decodeIfPresent(BaseStore.self, forKey: .store)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        features = try values.decodeIfPresent([Features].self, forKey: .features)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        hasCombination = try values.decodeIfPresent(Bool.self, forKey: .hasCombination)
        isFavorite = try values.decodeIfPresent(Bool.self, forKey: .isFavorite)
    }
    
}

//class Price : Codable{
//
//    var aed : Currency?
//    var usd : Currency?
//}

//class Characteristic : Codable {
//    let _id : String?
//    let title : String?
//    let titleEn : String?
//    let titleAn : String?
//    
//    enum CodingKeys: String, CodingKey {
//        
//        case _id = "_id"
//        case title = "title"
//        case titleEn = "titleEn"
//        case titleAn = "titleAn"
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        _id = try values.decodeIfPresent(String.self, forKey: ._id)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
//        titleAn = try values.decodeIfPresent(String.self, forKey: .titleAn)
//    }
//    
//}
class Features : Codable {
    let _id : String?
    let title : String?
    let titleEn : String?
    let titleAr : String?
    let characteristic : Characteristic?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
        case characteristic = "characteristic"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        characteristic = try values.decodeIfPresent(Characteristic.self, forKey: .characteristic)
    }
    
}

struct Currency : Codable {
    let amount : Double?
    let rate : Double?
    let symbol : String?
    let formattedAmount : String?
    var formattedText : String? {
        get {
            if let symbol = symbol, let formattedAmount = formattedAmount{
                return "\(symbol) \(formattedAmount)"
            }
            return nil
            
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case amount = "amount"
        case rate = "rate"
        case symbol = "symbol"
        case formattedAmount = "formattedAmount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Double.self, forKey: .amount)
        rate = try values.decodeIfPresent(Double.self, forKey: .rate)
        symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        formattedAmount = try values.decodeIfPresent(String.self, forKey: .formattedAmount)
    }
    
}
struct Price : Codable {
    let aed : Currency?
    let usd : Currency?
    var showPrice : Currency? {
        get {
            if AppSettings.currency == .usd{
                return usd
            }
            else{
                return aed
            }
            
        }
    }
    
    enum CodingKeys: String, CodingKey {
        
        case aed = "aed"
        case usd = "usd"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        aed = try values.decodeIfPresent(Currency.self, forKey: .aed)
        usd = try values.decodeIfPresent(Currency.self, forKey: .usd)
    }
    
}

struct BaseStore : Codable {
    let storeID : String?
    let storeName : String?
    let storeNameEn : String?
    let storeNameAr : String?
    let image : String?
    let phone : String?
    enum CodingKeys: String, CodingKey {
        
        case storeID = "_id"
        case storeName = "storeName"
        case storeNameEn = "storeNameEn"
        case storeNameAr = "storeNameAr"
        case image = "image"
        case phone = "phone"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        storeID = try values.decodeIfPresent(String.self, forKey: .storeID)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
    }
    
}
struct ImageObject : Codable {
    let path : String?
    let isDefault : Bool?
    let _id : String?
    
    enum CodingKeys: String, CodingKey {
        
        case path = "path"
        case isDefault = "isDefault"
        case _id = "_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        isDefault = try values.decodeIfPresent(Bool.self, forKey: .isDefault)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }
    
}

class FilterStoreAPIResponse : APIResponse{
    var StoreList : [BaseStore]?
    private enum CodingKeys: String, CodingKey {
        case StoreList = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        StoreList = try containter.decodeIfPresent([BaseStore].self, forKey: .StoreList)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}

