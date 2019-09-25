//
//  RootProductDetailModel.swift
//  TailerOnline
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper


class RootProductDetailModel : NSObject, Mappable{
    
    var data : ProductDetailDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootProductDetailModel()
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


class ProductDetailDataModel : NSObject, Mappable{
    
    var id : String?
    var available : Int?
    var averageRating : Double?
    var canReviewUsers : [CanReviewUser]?
    var categories : [CategoryModel]?
    var combinations : [Combination]?
    var descriptionField : String?
    var descriptionAr : String?
    var descriptionEn : String?
    var features : [String]?
    var images : [ImageModel]?
    var price : Price?
    var priceables : [Priceable]?
    var purchasedViews : Int?
    var reviews : [ReviewModel]?
    var store : StoreModel?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    var type : String?
    var views : Int?
    var offer : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return ProductDetailDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map) {
        id <- map["_id"]
        available <- map["available"]
        averageRating <- map["averageRating"]
        canReviewUsers <- map["canReviewUsers"]
        categories <- map["categories"]
        combinations <- map["combinations"]
        descriptionField <- map["description"]
        descriptionAr <- map["descriptionAr"]
        descriptionEn <- map["descriptionEn"]
        features <- map["features"]
        images <- map["images"]
        price <- map["price"]
        priceables <- map["priceables"]
        purchasedViews <- map["purchasedViews"]
        reviews <- map["reviews"]
        store <- map["store"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        type <- map["type"]
        views <- map["views"]
        offer <- map["offer"]
    }
}



class ReviewModel : NSObject, Mappable{
    
    var id : String?
    var comment : String?
    var createdAt : String?
    var rating : Double?
    var user : User? //becarefull
    
    var ratingStr: String! {
        get {
            return "\(rating ?? 0)"
        }
    }
    
    class func newInstance(map: Map) -> Mappable?{
        return ReviewModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        comment <- map["comment"]
        createdAt <- map["createdAt"]
        rating <- map["rating"]
        user <- map["user"]
        
    }
}

class Priceable : NSObject, Mappable{
    
    var id : String?
    var characteristics : [CharacteristicModel]?
    var feature : FeatureModel?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Priceable()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        characteristics <- map["characteristics"]
        feature <- map["feature"]
        
    }

}

class Combination : NSObject, Mappable{
    
    var id : String?
    var available : Int?
    var characteristics : [String]?
    var features : [String]?
    var images : [ImageModel]?
    var price : Price?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Combination()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        available <- map["available"]
        characteristics <- map["characteristics"]
        features <- map["features"]
        images <- map["images"]
        price <- map["price"]
        
    }
    
}
