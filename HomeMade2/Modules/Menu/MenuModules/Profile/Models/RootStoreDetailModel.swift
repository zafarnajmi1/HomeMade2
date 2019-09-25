//
//  RootStoreDetailModel.swift
//  TailerOnline
//
//  Created by apple on 4/8/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper


class RootStoreDetailModel : NSObject, Mappable{
    
    var data : StoreModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootStoreDetailModel()
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
