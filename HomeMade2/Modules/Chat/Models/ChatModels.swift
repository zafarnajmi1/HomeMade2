//
//  ChatModels.swift
//  HomeMade2
//
//  Created by Apple on 10/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ChatServerResponse : APIResponse {
    let data : ChatObject?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(ChatObject.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
class NewMessageServerResponse : APIResponse {
    let data : NewMessageObject?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(NewMessageObject.self, forKey: .data)
        try super.init(from: decoder)
    }
    
}
struct NewMessageObject : Codable {

    let message : Message?
    
    enum CodingKeys: String, CodingKey {
        

        case message = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        message = try values.decodeIfPresent(Message.self, forKey: .message)
    }
    
}
struct ChatObject : Codable {
    let pagination : Pagination?
    let messages : [Message]?
    
    enum CodingKeys: String, CodingKey {
        
        case pagination = "pagination"
        case messages = "messages"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        messages = try values.decodeIfPresent([Message].self, forKey: .messages)
    }
    
}

struct Message : Codable {
    let _id : String?
    let mimeType : String?
    let sender : String?
    let content : String?
    let conversation : String?
    var seen : Bool?
    let updatedAt : String?
    let createdAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case mimeType = "mimeType"
        case sender = "sender"
        case content = "content"
        case conversation = "conversation"
        case seen = "seen"
        case updatedAt = "updatedAt"
        case createdAt = "createdAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        mimeType = try values.decodeIfPresent(String.self, forKey: .mimeType)
        sender = try values.decodeIfPresent(String.self, forKey: .sender)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        conversation = try values.decodeIfPresent(String.self, forKey: .conversation)
        seen = try values.decodeIfPresent(Bool.self, forKey: .seen)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
    }
    
}
