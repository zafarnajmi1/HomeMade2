//
//  CheckoutModels.swift
//  HomeMade2
//
//  Created by Apple on 27/06/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class updateAddressAPIResponse: APIResponse {
    var data : UpdateAddressObject?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(UpdateAddressObject.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}
struct UpdateAddressObject : Codable {

    let _id : String?
    let addresses : [PaymentAddress]?

    
    enum CodingKeys: String, CodingKey {
        case _id = "_id"
        case addresses = "addresses"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        addresses = try values.decodeIfPresent([PaymentAddress].self, forKey: .addresses)
        
    }
}


struct PaymentAddress : Codable {
    let email : String?
    let phone : String?
    let postCode : String?
    let address1 : String?
    let address2 : String?
    let address3 : String?
    let addressType : String?
    let _id : String?
    let lastName : String?
    let firstName : String?
    
    enum CodingKeys: String, CodingKey {
        
        case email = "email"
        case phone = "phone"
        case postCode = "postCode"
        case address1 = "address1"
        case address2 = "address2"
        case address3 = "address3"
        case addressType = "addressType"
        case _id = "_id"
        case lastName = "lastName"
        case firstName = "firstName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        postCode = try values.decodeIfPresent(String.self, forKey: .postCode)
        address1 = try values.decodeIfPresent(String.self, forKey: .address1)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        address3 = try values.decodeIfPresent(String.self, forKey: .address3)
        addressType = try values.decodeIfPresent(String.self, forKey: .addressType)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
    }
    
}
