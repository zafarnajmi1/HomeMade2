//
//  RootUploadCompleteModel.swift
//  TailerOnline
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//
import ObjectMapper

class RootUploadCompleteModel: NSObject, Mappable{
    
    var data : UploadCompleteDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootUploadCompleteModel()
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


class UploadCompleteDataModel: NSObject, Mappable{

    var fileName : String?
    var pointer : String?
    var progress : Double?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return UploadCompleteDataModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map)
    {
        fileName <- map["fileName"]
        pointer <- map["pointer"]
        progress <- map["progress"]
       
        
    }
    
}
class UploadDataResponse : APIResponse {
    
    var data : UploadedChunck?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(UploadedChunck.self, forKey: .data)
        try super.init(from: decoder)
    }
}

class UploadedChunck: Codable{
    
    var fileName : String?
    var pointer : String?
    var progress : Double?
    enum CodingKeys: String, CodingKey {
        case fileName = "fileName"
        case pointer = "pointer"
        case progress = "progress"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fileName = try values.decodeIfPresent(String.self, forKey: .fileName)
        pointer = try values.decodeIfPresent(String.self, forKey: .pointer)
        progress = try values.decodeIfPresent(Double.self, forKey: .progress)
    }
    
}
