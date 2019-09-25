//
//  CategoryModels.swift
//  HomeMade2
//
//  Created by Apple on 13/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//




class CategoryAPIResponse : Codable{
    var errors : [String : String]?
    var message : String?
    var success : Bool?
    var data : [Category]?
    //    var errors : [String : String]?
    //    var message : String?
    //    var success : Bool?
    
    
    //    class func newInstance(map: Map) -> Mappable?{
    //        return SettingAPIResponse()
    //    }
    //    required init?(map: Map){}
    //    private override init(){}
    //
    //    func mapping(map: Map)
    //    {
    //        data <- map["data"]
    //        errors <- map["errors"]
    //        message <- map["message"]
    //        success <- map["success"]
    //
    //    }
}

class Category : Codable{
    
    var _id : String?
    var children : [Subcategory]?
    var image : String?
    var title : String?
    var titleAr : String?
    var titleEn : String?
    var isSelected : Bool? = false
    

}

class Subcategory : Codable{
    var _id : String?
    //    var children : [String]?
    var image : String?
    var depth : Int?
    var title : String?
    var titleAr : String?
    var titleEn : String?
}
