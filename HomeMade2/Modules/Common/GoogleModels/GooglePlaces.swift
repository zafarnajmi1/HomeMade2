//
//  GooglePlaces.swift
//  HomeMade2
//
//  Created by Apple on 05/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


struct GoogleAddressAPIResponse: Codable   {
    let pluscode : PlusCode?
    let results : [Result]?
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        
        case pluscode = "plus_code"
        case results = "results"
        case status = "status"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pluscode = try values.decodeIfPresent(PlusCode.self, forKey: .pluscode)
        results = try values.decodeIfPresent([Result].self, forKey: .results)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        
    }
}
struct PlusCode: Codable  {
    let compound_code : String?
    let global_code : String?
    
    enum CodingKeys: String, CodingKey {
        
        case compound_code = "compound_code"
        case global_code = "global_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        compound_code = try values.decodeIfPresent(String.self, forKey: .compound_code)
        global_code = try values.decodeIfPresent(String.self, forKey: .global_code)
    }
}

//struct Json4Swift_Base : Codable {
//    let results : [Result]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case results = "results"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        results = try values.decodeIfPresent([Result].self, forKey: .results)
//    }
//
//}
struct Result : Codable {
    let address_components : [Address_components]?
    let formatted_address : String?
    let geometry : Geometry?
    let place_id : String?
    let types : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case address_components = "address_components"
        case formatted_address = "formatted_address"
        case geometry = "geometry"
        case place_id = "place_id"
        case types = "types"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        address_components = try values.decodeIfPresent([Address_components].self, forKey: .address_components)
        formatted_address = try values.decodeIfPresent(String.self, forKey: .formatted_address)
        geometry = try values.decodeIfPresent(Geometry.self, forKey: .geometry)
        place_id = try values.decodeIfPresent(String.self, forKey: .place_id)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }
    
}
struct Geometry : Codable {
    let location : Location?
    let location_type : String?
    let viewport : Viewport?
    
    enum CodingKeys: String, CodingKey {
        
        case location = "location"
        case location_type = "location_type"
        case viewport = "viewport"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        location_type = try values.decodeIfPresent(String.self, forKey: .location_type)
        viewport = try values.decodeIfPresent(Viewport.self, forKey: .viewport)
    }
    
}
struct Viewport : Codable {
    let northeast : Intercardinal?
    let southwest : Intercardinal?
    
    enum CodingKeys: String, CodingKey {
        
        case northeast = "northeast"
        case southwest = "southwest"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        northeast = try values.decodeIfPresent(Intercardinal.self, forKey: .northeast)
        southwest = try values.decodeIfPresent(Intercardinal.self, forKey: .southwest)
    }
    
}

struct Intercardinal : Codable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
    
}
//struct NorthEast : Codable {
//    let lat : Double?
//    let lng : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case lat = "lat"
//        case lng = "lng"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
//        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
//    }
//
//}
//
//struct SouthWest : Codable {
//    let lat : Double?
//    let lng : Double?
//
//    enum CodingKeys: String, CodingKey {
//
//        case lat = "lat"
//        case lng = "lng"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
//        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
//    }
//
//}

struct Location : Codable {
    let lat : Double?
    let lng : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(Double.self, forKey: .lat)
        lng = try values.decodeIfPresent(Double.self, forKey: .lng)
    }
    
}
struct Address_components : Codable {
    let long_name : String?
    let short_name : String?
    let types : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case long_name = "long_name"
        case short_name = "short_name"
        case types = "types"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        long_name = try values.decodeIfPresent(String.self, forKey: .long_name)
        short_name = try values.decodeIfPresent(String.self, forKey: .short_name)
        types = try values.decodeIfPresent([String].self, forKey: .types)
    }
    
}
