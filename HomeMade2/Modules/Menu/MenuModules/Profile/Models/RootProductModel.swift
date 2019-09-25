//
//  RootProductModel.swift
//  TailerOnline
//
//  Created by apple on 4/3/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper


class RootProductModel : NSObject, Mappable{
    
    var data : [ProductModel]?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootProductModel()
    }
    required init?(map: Map){}
     override init(){}
    
    func mapping(map: Map)
    {
        data <- map["data"]
        errors <- map["errors"]
        message <- map["message"]
        success <- map["success"]
        
    }
    
}

class ProductModel : NSObject, Mappable{
    
    var id : String?
    var averageRating : Double?
    var categories : [String]?
    var features : [FeatureModel]?
    var image : String?
    var images : [ImageModel]?
    var isFeatured : Bool?
    var offer : String?
    var offerAr : String?
    var offerEn : String?
    var price : Price?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    var type : String?
    var store: StoreModel?
    
    class func newInstance(map: Map) -> Mappable?{
        return ProductModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        averageRating <- map["averageRating"]
        categories <- map["categories"]
        features <- map["features"]
        image <- map["image"]
        images <- map["images"]
        isFeatured <- map["isFeatured"]
        offer <- map["offer"]
        offerAr <- map["offerAr"]
        offerEn <- map["offerEn"]
        price <- map["price"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        type <- map["type"]
        store <- map["store"]
    }
    
}

class ImageModel : NSObject,  Mappable{
    
    var id : String?
    var isDefault : Bool?
    var path : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ImageModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        isDefault <- map["isDefault"]
        path <- map["path"]
        
    }
    
}

class FeatureModel : NSObject, Mappable{
    
    var id : String?
    var characteristic : CharacteristicModel?
    var characteristics: [CharacteristicModel]?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return FeatureModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        characteristic <- map["characteristic"]
        characteristics <- map["characteristics"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        
    }
    
}


class CharacteristicModel : NSObject, Mappable{
    
    var id : String?
    var feature : String?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    var image : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return CharacteristicModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        feature <- map["feature"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        image <- map["image"]
    }
    
}

class CanReviewUser : NSObject, Mappable{
    
    var id : String?
    var combination : String?
    var order : String?
    var orderDetail : String?
    var product : String?
    var store : String?
    var user : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CanReviewUser()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        combination <- map["combination"]
        order <- map["order"]
        orderDetail <- map["orderDetail"]
        product <- map["product"]
        store <- map["store"]
        user <- map["user"]
    }
    
}
