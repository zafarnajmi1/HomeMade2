//
//  RootStoreModel.swift
//  TailerOnline
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootStoreModel : NSObject, Mappable{
    
    var data : StoreDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootStoreModel()
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

class StoreDataModel : NSObject, Mappable{
    
    var pagination : Pagination?
    var stores : [StoreModel]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return StoreDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        pagination <- map["pagination"]
        stores <- map["stores"]
        
    }
    
}

class StoreModel : NSObject, Mappable{
    
    var id : String?
    var address : String?
    var descriptionField : String?
    var descriptionAr : String?
    var descriptionEn : String?
    var image : String?
    var phone : String?
    var storeName : String?
    var storeNameAr : String?
    var storeNameEn : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return StoreModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        address <- map["address"]
        descriptionField <- map["description"]
        descriptionAr <- map["descriptionAr"]
        descriptionEn <- map["descriptionEn"]
        image <- map["image"]
        phone <- map["phone"]
        storeName <- map["storeName"]
        storeNameAr <- map["storeNameAr"]
        storeNameEn <- map["storeNameEn"]
        
    }
    
    
}

class Pagination : NSObject, Mappable{
    
    var next : Int?
    var page : Int?
    var pages : Int?
    var perPage : Int?
    var previous : Int?
    var total : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Pagination()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        next <- map["next"]
        page <- map["page"]
        pages <- map["pages"]
        perPage <- map["per_page"]
        previous <- map["previous"]
        total <- map["total"]
        
    }

}
