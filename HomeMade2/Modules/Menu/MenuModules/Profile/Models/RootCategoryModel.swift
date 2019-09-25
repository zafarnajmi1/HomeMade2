//
//  RootCategoryModel.swift
//  TailerOnline
//
//  Created by apple on 4/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootCategoryModel : NSObject, Mappable{
    
    var data : CategoryDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootCategoryModel()
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

class CategoryDataModel : NSObject,  Mappable{
    
    var collection : [CategoryModel]?
    var pagination : Pagination?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CategoryDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        collection <- map["collection"]
        pagination <- map["pagination"]
        
    }
    
}

