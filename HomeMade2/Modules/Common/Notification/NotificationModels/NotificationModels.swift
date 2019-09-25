//
//  NotificationModels.swift
//  HomeMade2
//
//  Created by Apple on 11/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class NotificationServerResponse : APIResponse {
    let data : NotificationResponse?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(NotificationResponse.self, forKey: .data)
        try super.init(from: decoder)
    }
}


struct NotificationResponse : Codable {
    let notifications : [Notification]?
    let unseenNotificationsCount : Int?
    let pagination : Pagination?
    
    enum CodingKeys: String, CodingKey {
        
        case notifications = "notifications"
        case unseenNotificationsCount = "unseenNotificationsCount"
        case pagination = "pagination"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        notifications = try values.decodeIfPresent([Notification].self, forKey: .notifications)
        unseenNotificationsCount = try values.decodeIfPresent(Int.self, forKey: .unseenNotificationsCount)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
    }
    
}
struct Extras : Codable {
    let product : String?
    let conversation : String?
    let order : String?
    
    enum CodingKeys: String, CodingKey {
        
        case product = "product"
        case conversation = "conversation"
        case order = "order"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product = try values.decodeIfPresent(String.self, forKey: .product)
        conversation = try values.decodeIfPresent(String.self, forKey: .conversation)
        order = try values.decodeIfPresent(String.self, forKey: .order)
    }
    
}

class Notification : Codable {
    let description : String?
    let extras : Extras?
    let updatedAt : String?
    let receiver : User?
    let read : Bool?
    let titleAr : String?
    let _id : String?
    let descriptionEn : String?
    let title : String?
    let action : String?
    let titleEn : String?
    var seen : Bool?
    let descriptionAr : String?
    let sender : User?
    let createdAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case description = "description"
        case extras = "extras"
        case updatedAt = "updatedAt"
        case receiver = "receiver"
        case read = "read"
        case titleAr = "titleAr"
        case _id = "_id"
        case descriptionEn = "descriptionEn"
        case title = "title"
        case action = "action"
        case titleEn = "titleEn"
        case seen = "seen"
        case descriptionAr = "descriptionAr"
        case sender = "sender"
        case createdAt = "createdAt"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        extras = try values.decodeIfPresent(Extras.self, forKey: .extras)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        receiver = try values.decodeIfPresent(User.self, forKey: .receiver)
        read = try values.decodeIfPresent(Bool.self, forKey: .read)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        descriptionEn = try values.decodeIfPresent(String.self, forKey: .descriptionEn)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        action = try values.decodeIfPresent(String.self, forKey: .action)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        seen = try values.decodeIfPresent(Bool.self, forKey: .seen)
        descriptionAr = try values.decodeIfPresent(String.self, forKey: .descriptionAr)
        sender = try values.decodeIfPresent(User.self, forKey: .sender)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}
