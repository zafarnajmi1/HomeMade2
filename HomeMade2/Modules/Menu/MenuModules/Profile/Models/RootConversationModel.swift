//
//  RootConversationModel.swift
//  TailerOnline
//
//  Created by apple on 4/19/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootConversationModel : NSObject, Mappable{
    
    var data : ConversationDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootConversationModel()
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

class ConversationDataModel : NSObject,  Mappable{
    
    var conversation : ConversationModel?
    var conversations: [ConversationModel]?
    
    class func newInstance(map: Map) -> Mappable?{
        return ConversationModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        conversation <- map["conversation"]
        conversations <- map["conversations"]
        
    }
    
}

class ConversationModel : NSObject, Mappable{
    
    var id : String?
    var createdAt : String?
    var lastMessage : LastMessageModel?
    var product : ProductModel?
    var store : StoreModel?
    var updatedAt : String?
    var user : LoginResponse?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ConversationModel()
    }
    required init?(map: Map){}
    override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        createdAt <- map["createdAt"]
        lastMessage <- map["lastMessage"]
        product <- map["product"]
        store <- map["store"]
        updatedAt <- map["updatedAt"]
        user <- map["user"]
        
    }

}


class LastMessageModel : NSObject, Mappable{
    
    var id : String?
    var content : String?
    var conversation : String?
    var createdAt : String?
    var mimeType : String?
    var sender : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return LastMessageModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        content <- map["content"]
        conversation <- map["conversation"]
        createdAt <- map["createdAt"]
        mimeType <- map["mimeType"]
        sender <- map["sender"]
        updatedAt <- map["updatedAt"]
        
    }
    
}
