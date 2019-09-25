//
//  RootNotificationModel.swift
//  TailerOnline
//
//  Created by apple on 4/18/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
import ObjectMapper


class RootNotificationModel : NSObject, Mappable{
    
    var data : NotificationDataModel?
    var errors : Error?
    var message : String?
    var success : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RootNotificationModel()
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

class NotificationDataModel : NSObject, Mappable{
    
    var notifications : [NotificationModel]?
    var pagination : Pagination?
    var unseenNotificationsCount : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return NotificationDataModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        notifications <- map["notifications"]
        pagination <- map["pagination"]
        unseenNotificationsCount <- map["unseenNotificationsCount"]
        
    }
}

class NotificationModel : NSObject, Mappable{
    
    var id : String?
    var action : String?
    var createdAt : String?
    var descriptionField : String?
    var extras : ExtraModel?
    var read : Bool?
    var receiver : String?
    var seen : Bool?
    var sender : LoginResponse?
    var title : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return NotificationModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        action <- map["action"]
        createdAt <- map["createdAt"]
        descriptionField <- map["description"]
        extras <- map["extras"]
        read <- map["read"]
        receiver <- map["receiver"]
        seen <- map["seen"]
        sender <- map["sender"]
        title <- map["title"]
        updatedAt <- map["updatedAt"]
        
    }
    
}

class Title : NSObject, Mappable{
    
    var ar : String?
    var en : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Title()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        ar <- map["ar"]
        en <- map["en"]
        
    }
}

class ExtraModel : NSObject, Mappable{
    
    var conversation : String?
    var product : String?
    var order : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return ExtraModel()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        conversation <- map["conversation"]
        product <- map["product"]
        order <- map["order"]
        
    }
    
}
