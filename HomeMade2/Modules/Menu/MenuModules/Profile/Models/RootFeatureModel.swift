//
//  RootFeatureModel.swift
//  TailerOnline
//
//  Created by apple on 4/12/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootFeatureModel : NSObject, Mappable{
    
    var data : [FeatureModel]?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootFeatureModel()
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

