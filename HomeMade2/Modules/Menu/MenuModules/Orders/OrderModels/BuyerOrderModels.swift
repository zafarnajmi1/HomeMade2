//
//  OrderModels.swift
//  HomeMade2
//
//  Created by Apple on 01/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class BuyerOrdersAPIResponse: APIResponse {
    var data : [BuyerOrder]?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent([BuyerOrder].self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
class BuyerOrderDetailAPIResponse: APIResponse {
    var data : BuyerOrder?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(BuyerOrder.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
class BuyerOrder : Codable {
    let _id : String?
    var orderDetails : [OrderProductDetail]?
    let status : String?
    let charges : Price?
    let total : Price?
    let orderCharges : Int?
    let orderNumber : String?
    let payerStatus : String?
    let orderStatus : String?
    let firstName : String?
    let lastName : String?
    let payerId : String?
    let payerEmail : String?
    let paymentId : String?
    let state : String?
    let paymentMethod : String?
    let currency : String?
    let transactionDetails : String?
    let orderNote : String?
    let user : User?
    let addresses : [Addresse]?
    let createdAt : String?
    let updatedAt : String?
    var statusString : String = ""
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case orderDetails = "orderDetails"
        case status = "status"
        case charges = "charges"
        case total = "total"
        case orderCharges = "orderCharges"
        case orderNumber = "orderNumber"
        case payerStatus = "payerStatus"
        case orderStatus = "orderStatus"
        case firstName = "firstName"
        case lastName = "lastName"
        case payerId = "payerId"
        case payerEmail = "payerEmail"
        case paymentId = "paymentId"
        case state = "state"
        case paymentMethod = "paymentMethod"
        case currency = "currency"
        case transactionDetails = "transactionDetails"
        case orderNote = "orderNote"
        case user = "user"
        case addresses = "addresses"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        orderDetails = try values.decodeIfPresent([OrderProductDetail].self, forKey: .orderDetails)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        charges = try values.decodeIfPresent(Price.self, forKey: .charges)
        total = try values.decodeIfPresent(Price.self, forKey: .total)
        orderCharges = try values.decodeIfPresent(Int.self, forKey: .orderCharges)
        orderNumber = try values.decodeIfPresent(String.self, forKey: .orderNumber)
        payerStatus = try values.decodeIfPresent(String.self, forKey: .payerStatus)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        payerId = try values.decodeIfPresent(String.self, forKey: .payerId)
        payerEmail = try values.decodeIfPresent(String.self, forKey: .payerEmail)
        paymentId = try values.decodeIfPresent(String.self, forKey: .paymentId)
        state = try values.decodeIfPresent(String.self, forKey: .state)
        paymentMethod = try values.decodeIfPresent(String.self, forKey: .paymentMethod)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        transactionDetails = try values.decodeIfPresent(String.self, forKey: .transactionDetails)
        orderNote = try values.decodeIfPresent(String.self, forKey: .orderNote)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        addresses = try values.decodeIfPresent([Addresse].self, forKey: .addresses)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        
        
        var confirmed : Int = 0
        var completed : Int = 0
        var shipped : Int = 0
        for object in orderDetails ?? []{
            if object.status == "confirmed"{
                confirmed += 1
            }
            else if object.status == "shipped"{
                shipped += 1
            }
            else if object.status == "completed"{
                completed += 1
            }
        }
        var confirmedString : String = ""
        var completedString : String = ""
        var shippedString : String = ""
        if confirmed > 0{
            confirmedString = "Confirmed".localized + "(\(confirmed))"
        }
        if shipped > 0{
            completedString = "Shipped".localized + "(\(shipped))"
        }
        if completed > 0{
            shippedString = "Completed".localized + "(\(completed))"
        }
        statusString = confirmedString + shippedString + completedString
        
        
    }
    
}



class OrderProductDetail : Codable {
    let _id : String?
    let price : Price?
    let total : Price?
    let quantity : Int?
    var status : String?
    let specialistVisitDateTime : String?
    let specialistVisitAddress : String?
    let specialistVisitLocation : [Int]?
    let sizeImage : String?
    let order : String?
    let product : OrderProduct?
    let store : String?
    let combination : String?
    let combinationDetail : [OrderCombination]?
    let images : [ImageObject]?
    let createdAt : String?
    let updatedAt : String?
    let image : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case price = "price"
        case total = "total"
        case quantity = "quantity"
        case status = "status"
        case specialistVisitDateTime = "specialistVisitDateTime"
        case specialistVisitAddress = "specialistVisitAddress"
        case specialistVisitLocation = "specialistVisitLocation"
        case sizeImage = "sizeImage"
        case order = "order"
        case product = "product"
        case store = "store"
        case combination = "combination"
        case combinationDetail = "combinationDetail"
        case images = "images"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case image = "image"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        total = try values.decodeIfPresent(Price.self, forKey: .total)
        quantity = try values.decodeIfPresent(Int.self, forKey: .quantity)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        specialistVisitDateTime = try values.decodeIfPresent(String.self, forKey: .specialistVisitDateTime)
        specialistVisitAddress = try values.decodeIfPresent(String.self, forKey: .specialistVisitAddress)
        specialistVisitLocation = try values.decodeIfPresent([Int].self, forKey: .specialistVisitLocation)
        sizeImage = try values.decodeIfPresent(String.self, forKey: .sizeImage)
        order = try values.decodeIfPresent(String.self, forKey: .order)
        product = try values.decodeIfPresent(OrderProduct.self, forKey: .product)
        store = try values.decodeIfPresent(String.self, forKey: .store)
        combination = try values.decodeIfPresent(String.self, forKey: .combination)
        combinationDetail = try values.decodeIfPresent([OrderCombination].self, forKey: .combinationDetail)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }
    
}
struct OrderProduct : Codable {
    let _id : String?
    let title : String?
    let store : BaseStore?
    let images : [ImageObject]?
    let titleEn : String?
    let titleAr : String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case store = "store"
        case images = "images"
        case titleEn = "titleEn"
        case titleAr = "titleAr"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        store = try values.decodeIfPresent(BaseStore.self, forKey: .store)
        images = try values.decodeIfPresent([ImageObject].self, forKey: .images)
        titleEn = try values.decodeIfPresent(String.self, forKey: .titleEn)
        titleAr = try values.decodeIfPresent(String.self, forKey: .titleAr)
    }
    
}
struct OrderCombination : Codable {
    let _id : String?
    let feature : Feature?
    let characteristic : Characteristic?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case feature = "feature"
        case characteristic = "characteristic"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        feature = try values.decodeIfPresent(Feature.self, forKey: .feature)
        characteristic = try values.decodeIfPresent(Characteristic.self, forKey: .characteristic)
    }
    
}


class OrderStatusAPIResponse: APIResponse {
    var data : OrderStatus?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(OrderStatus.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
class OrderStatus : Codable {
    var confirmed : Int?
    var shipped : Int?
    var completed : Int?
    var cancelled : Int?
    private enum CodingKeys: String, CodingKey {
        case confirmed = "confirmedOrdersCount"
        case shipped = "shippedOrdersCount"
        case completed = "completedOrdersCount"
        case cancelled = "cancelledOrdersCount"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        confirmed = try containter.decodeIfPresent(Int.self, forKey: .confirmed)
        shipped = try containter.decodeIfPresent(Int.self, forKey: .shipped)
        completed = try containter.decodeIfPresent(Int.self, forKey: .completed)
        cancelled = try containter.decodeIfPresent(Int.self, forKey: .cancelled)

    }
}
