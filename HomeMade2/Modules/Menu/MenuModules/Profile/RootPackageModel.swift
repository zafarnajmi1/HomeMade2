//
//  RootPackageModel.swift
//  TailerOnline
//
//  Created by apple on 4/3/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper

class RootPackageModel: NSObject, Mappable{
   
    var data : PackageDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootPackageModel()
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

class PackageDataModel : NSObject, Mappable{
    
    var collection : [PackageModel]?
    var pagination : Pagination?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return PackageDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        collection <- map["collection"]
        pagination <- map["pagination"]
        
    }
}

class PackageModel : NSObject, Mappable{
    
    var id : String?
    var createdAt : String?
    var isActive : Bool?
    var price : PriceInt?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    var updatedAt : String?
    var views : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return PackageModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        createdAt <- map["createdAt"]
        isActive <- map["isActive"]
        price <- map["price"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        updatedAt <- map["updatedAt"]
        views <- map["views"]
        
    }
    
}

class Price : NSObject,  Mappable{
    
    var aed : Any?
    var usd : Any?
    
    var aedS: String? {
        get{
            let value = aed as? Double
            return String(format: "%.1f", value ?? 0)
        }
       
    }
    
    var usdS: String? {
        get{
            let value = usd as? Double
            return String(format: "%.1f", value ?? 0)
        }
        
    }
    
    var aedD: Double? {
        get{ return aed as? Double }
        
    }
    
    var usdD: Double? {
        get{return usd as? Double}

    }
    
    class func newInstance(map: Map) -> Mappable?{
        return Price()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        aed <- map["aed"]
        usd <- map["usd"]
        
    }
}
