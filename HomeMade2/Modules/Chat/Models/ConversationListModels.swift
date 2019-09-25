//
//  ChatModels.swift
//  HomeMade2
//
//  Created by Apple on 09/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class ConversationObjectServerResponse : APIResponse {
    //    let message : String?
    let data : ConvesationObject?
    //    let errors : [String : ]?
    //    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        
        //        case message = "message"
        case data = "data"
        //        case errors = "errors"
        //        case success = "success"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        //        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ConvesationObject.self, forKey: .data)
        //        errors = try values.decodeIfPresent(Errors.self, forKey: .errors)
        //        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        try super.init(from: decoder)
        
    }
    
}
struct ConvesationObject : Codable {

    let conversation : ListConversation?
    
    enum CodingKeys: String, CodingKey {
        
        case conversation = "conversation"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        conversation = try values.decodeIfPresent(ListConversation.self, forKey: .conversation)
    }
    
}
class ConversationListResponse : APIResponse {
//    let message : String?
    let data : ListResponse?
//    let errors : [String : ]?
//    let success : Bool?
    
    enum CodingKeys: String, CodingKey {
        
//        case message = "message"
        case data = "data"
//        case errors = "errors"
//        case success = "success"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(ListResponse.self, forKey: .data)
//        errors = try values.decodeIfPresent(Errors.self, forKey: .errors)
//        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        try super.init(from: decoder)
        
    }
    
}
struct ListResponse : Codable {
    let pagination : Pagination?
    let conversations : [ListConversation]?
    
    enum CodingKeys: String, CodingKey {
        
        case pagination = "pagination"
        case conversations = "conversations"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pagination = try values.decodeIfPresent(Pagination.self, forKey: .pagination)
        conversations = try values.decodeIfPresent([ListConversation].self, forKey: .conversations)
    }
    
}


struct ListConversation : Codable {
    let _id : String?
    let store : ConversationStore?
    let product : ConversationProduct?
    let lastMessage : LastMessage?
    let updatedAt : String?
    let createdAt : String?
    let user : ConversationListUser?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case store = "store"
        case product = "product"
        case lastMessage = "lastMessage"
        case updatedAt = "updatedAt"
        case createdAt = "createdAt"
        case user = "user"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        store = try values.decodeIfPresent(ConversationStore.self, forKey: .store)
        product = try values.decodeIfPresent(ConversationProduct.self, forKey: .product)
        lastMessage = try values.decodeIfPresent(LastMessage.self, forKey: .lastMessage)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        user = try values.decodeIfPresent(ConversationListUser.self, forKey: .user)
    }
    
}
struct ConversationProduct : Codable {
    let _id : String?
    let images : [ImageObject]?
    let price : Price?
    let title : String?
    let titleAr : String?
    let image : String?
    let updatedAt : String?
    let createdAt : String?
    let titleEn : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case images = "images"
        case price = "price"
        case title = "title"
        case titleAr = "titleAr"
        case image = "image"
        case updatedAt = "updatedAt"
        case createdAt = "createdAt"
        case titleEn = "titleEn"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
    }
    
}

struct LastMessage : Codable {
    
    let _id : String?
    let mimeType : String?
    let sender : String?
    let content : String?
    let conversation : String?
    let seen : Bool?
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



struct ConversationStore : Codable {
    let _id : String?
    let storeNameAr : String?
    let storeNameEn : String?
    let accountType : String?
    let image : String?
    let storeName : String?
    let createdAt : String?
    let updatedAt : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case storeNameAr = "storeNameAr"
        case storeNameEn = "storeNameEn"
        case accountType = "accountType"
        case image = "image"
        case storeName = "storeName"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
    }
    
}

struct ConversationListUser : Codable {
    let _id : String?
    let firstName : String?
    let accountType : String?
    let image : String?
    let updatedAt : String?
    let createdAt : String?
    let lastName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case firstName = "firstName"
        case accountType = "accountType"
        case image = "image"
        case updatedAt = "updatedAt"
        case createdAt = "createdAt"
        case lastName = "lastName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }
    
}

struct Pagination : Codable {
    let previous : Int?
    let pages : Int?
    let per_page : Int?
    let next : Int?
    let total : Int?
    let page : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case previous = "previous"
        case pages = "pages"
        case per_page = "per_page"
        case next = "next"
        case total = "total"
        case page = "page"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        previous = try values.decodeIfPresent(Int.self, forKey: .previous)
        pages = try values.decodeIfPresent(Int.self, forKey: .pages)
        per_page = try values.decodeIfPresent(Int.self, forKey: .per_page)
        next = try values.decodeIfPresent(Int.self, forKey: .next)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        page = try values.decodeIfPresent(Int.self, forKey: .page)
    }
    
}
