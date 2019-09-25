//
//  MoreDataModel.swift
//  TailerOnline
//
//  Created by apple on 4/4/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation



public class MoreData {
    public var success : Int?
    public var data : DataComplete?
    public var message : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [MoreData]
    {
        var models:[MoreData] = []
        for item in array
        {
            models.append(MoreData(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Int
        if (dictionary["data"] != nil) { data = DataComplete(dictionary: dictionary["data"] as! NSDictionary) }
        message = dictionary["message"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.success, forKey: "success")
        dictionary.setValue(self.data?.dictionaryRepresentation(), forKey: "data")
        dictionary.setValue(self.message, forKey: "message")
        
        return dictionary
    }
    
}


public class DataComplete {
    public var percent : Double?
    public var place : Int?
    public var pointer : String?
    
    public class func modelsFromDictionaryArray(array:NSArray) -> [DataComplete]
    {
        var models:[DataComplete] = []
        for item in array
        {
            models.append(DataComplete(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    required public init?(dictionary: NSDictionary) {
        
        percent = dictionary["percent"] as? Double
        place = dictionary["place"] as? Int
        pointer = dictionary["pointer"] as? String
    }
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.percent, forKey: "percent")
        dictionary.setValue(self.place, forKey: "place")
        dictionary.setValue(self.pointer, forKey: "pointer")
        
        return dictionary
    }
    
}
class MoreData1 : APIResponse {
//    public var success : B?
    public var data : DataComplete1?
//    public var message : String?
    
    enum CodingKeys: String, CodingKey {
//        case success = "success"
        case data = "data"
//        case message = "message"
        
    }
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        success = try values.decodeIfPresent(Int.self, forKey: .success)
        data = try values.decodeIfPresent(DataComplete1.self, forKey: .data)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
        try super.init(from: decoder)
    }
    
}
public class DataComplete1 : Decodable {
    public var percent : Double?
    public var place : Int?
    public var pointer : String?
    
    enum CodingKeys: String, CodingKey {
        case percent = "percent"
        case place = "place"
        case pointer = "pointer"
        
    }
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        percent = try values.decodeIfPresent(Double.self, forKey: .percent)
        place = try values.decodeIfPresent(Int.self, forKey: .place)
        pointer = try values.decodeIfPresent(String.self, forKey: .pointer)
        
    }
    /*
     let features : [String]?
     let characteristics : [String]?
     let price : Price?
     let available : Int?
     let _id : String?
     let images : [ImageObject]?
     
     enum CodingKeys: String, CodingKey {
     
     case features = "features"
     case characteristics = "characteristics"
     case price = "price"
     case available = "available"
     case _id = "_id"
     case images = "images"
     }
     
     required init(from decoder: Decoder) throws {
     let values = try decoder.container(keyedBy: CodingKeys.self)
     features = try values.decodeIfPresent([String].self, forKey: .features)
     characteristics = try values.decodeIfPresent([String].self, forKey: .characteristics)
     price = try values.decodeIfPresent(Price.self, forKey: .price)
     available = try values.decodeIfPresent(Int.self, forKey: .available)
     _id = try values.decodeIfPresent(String.self, forKey: ._id)
     images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
     }
     */
    
}
