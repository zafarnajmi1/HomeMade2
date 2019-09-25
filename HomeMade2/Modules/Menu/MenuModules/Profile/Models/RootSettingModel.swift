//
//  RootSettingModel.swift
//  TailerOnline
//
//  Created by apple on 4/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper



class CategoryModel : NSObject,  Mappable{
    
    var id : String?
    var children : [CategoryModel]?
    var descriptionField : String?
    var descriptionEn : String?
    var icon : String?
    var image : String?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return CategoryModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        children <- map["children"]
        descriptionField <- map["description"]
        descriptionEn <- map["descriptionEn"]
        icon <- map["icon"]
        image <- map["image"]
        title <- map["title"]
        titleAr <- map["titleAr"]
        titleEn <- map["titleEn"]
        
    }


}
