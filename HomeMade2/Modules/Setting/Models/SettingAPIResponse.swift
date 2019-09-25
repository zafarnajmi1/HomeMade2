//
//  RootSettingModel.swift
//  TailerOnline
//
//  Created by apple on 4/5/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation
//import ObjectMapper

class SettingAPIResponse :Codable{
    
    var data : SettingData?
    var errors : [String : String]?
    var message : String?
    var success : Bool?
    
    
//    class func newInstance(map: Map) -> Mappable?{
//        return SettingAPIResponse()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        data <- map["data"]
//        errors <- map["errors"]
//        message <- map["message"]
//        success <- map["success"]
//
//    }
}


class SettingData : Codable{
    
    var categories : [Category]?
//    var cities : [City]?
    var pages : [Page]?
//    var searchCities : [City]?
    var settings : Setting?
    
    
//    class func newInstance(map: Map) -> Mappable?{
//        return SettingData()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        categories <- map["categories"]
////        cities <- map["cities"]
//        pages <- map["pages"]
////        searchCities <- map["searchCities"]
//        settings <- map["settings"]
//
//    }
}

class Page : Codable{
    
    var id : String?
//    var createdAt : String?
    var detail : String?
    var detailAr : String?
    var detailEn : String?
    var image : String?
//    var slug : String?
    var title : String?
    var titleAr : String?
    var titleEn : String?
//    var updatedAt : String?
    
    
//    class func newInstance(map: Map) -> Mappable?{
//        return Page()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        id <- map["_id"]
////        createdAt <- map["createdAt"]
//        detail <- map["detail"]
//        detailAr <- map["detailAr"]
//        detailEn <- map["detailEn"]
//        image <- map["image"]
////        slug <- map["slug"]
//        title <- map["title"]
//        titleAr <- map["titleAr"]
//        titleEn <- map["titleEn"]
////        updatedAt <- map["updatedAt"]
//
//    }
}


struct Setting : Codable {
    var _id : String?
    var aboutShortDescription : String?
    var projectTitle : String?
    var contactFeedbackSelectors : String?
    var contactAddress : String?
    var contactEmail : String?
    var emailSenderName : String?
    var emailFrom : String?
    var facebook : String?
    var twitter : String?
    var google : String?
    var pinterest : String?
    var phone1 : String?
    var phone2 : String?
    var latitude : String?
    var longitude : String?
    var serviceCharges : Int?
    var serviceChargesPersentage : Int?
    var paypalClientId : String?
    var paypalProductionKey : String?
    var paypalClientSecret : String?
    var paypalEnv : String?
    var createdAt : String?
    var updatedAt : String?
    var paypalLiveClientId : String?
    var paypalLiveClientSecret : String?
    var paypalMode : String?
    var paypalSandboxClientId : String?
    var paypalSandboxClientSecret : String?
    var location : [Double]?
    var aboutUs : String?
    var contactNumber : String?
    var instagram : String?
    var privacyPolicy : String?
    var termsAndConditions : String?
    var footerStartLogo : String?
    var headerLogo : String?
    var aboutShortDescriptionEn : String?
    var aboutShortDescriptionAr : String?
    var contactFeedbackSelectorsEn : String?
    var contactFeedbackSelectorsAr : String?
    var contactAddressEn : String?
    var contactAddressAr : String?
    var projectTitleEn : String?
    var projectTitleAr : String?
    var emailSenderNameEn : String?
    var emailSenderNameAr : String?
    var minPrice : Price?
    var maxPrice : Price?
}
    
//    init?(map: Map) {
//        
//    }
//    
//    mutating func mapping(map: Map) {
//        
//        _id <- map["_id"]
//        aboutShortDescription <- map["aboutShortDescription"]
//        projectTitle <- map["projectTitle"]
//        contactFeedbackSelectors <- map["contactFeedbackSelectors"]
//        contactAddress <- map["contactAddress"]
//        contactEmail <- map["contactEmail"]
//        emailSenderName <- map["emailSenderName"]
//        emailFrom <- map["emailFrom"]
//        facebook <- map["facebook"]
//        twitter <- map["twitter"]
//        google <- map["google"]
//        pinterest <- map["pinterest"]
//        phone1 <- map["phone1"]
//        phone2 <- map["phone2"]
//        latitude <- map["latitude"]
//        longitude <- map["longitude"]
//        serviceCharges <- map["serviceCharges"]
//        serviceChargesPersentage <- map["serviceChargesPersentage"]
//        paypalClientId <- map["paypalClientId"]
//        paypalProductionKey <- map["paypalProductionKey"]
//        paypalClientSecret <- map["paypalClientSecret"]
//        paypalEnv <- map["paypalEnv"]
//        createdAt <- map["createdAt"]
//        updatedAt <- map["updatedAt"]
//        paypalLiveClientId <- map["paypalLiveClientId"]
//        paypalLiveClientSecret <- map["paypalLiveClientSecret"]
//        paypalMode <- map["paypalMode"]
//        paypalSandboxClientId <- map["paypalSandboxClientId"]
//        paypalSandboxClientSecret <- map["paypalSandboxClientSecret"]
//        location <- map["location"]
//        aboutUs <- map["aboutUs"]
//        contactNumber <- map["contactNumber"]
//        instagram <- map["instagram"]
//        privacyPolicy <- map["privacyPolicy"]
//        termsAndConditions <- map["termsAndConditions"]
//        footerStartLogo <- map["footerStartLogo"]
//        headerLogo <- map["headerLogo"]
//        aboutShortDescriptionEn <- map["aboutShortDescriptionEn"]
//        aboutShortDescriptionAr <- map["aboutShortDescriptionAr"]
//        contactFeedbackSelectorsEn <- map["contactFeedbackSelectorsEn"]
//        contactFeedbackSelectorsAr <- map["contactFeedbackSelectorsAr"]
//        contactAddressEn <- map["contactAddressEn"]
//        contactAddressAr <- map["contactAddressAr"]
//        projectTitleEn <- map["projectTitleEn"]
//        projectTitleAr <- map["projectTitleAr"]
//        emailSenderNameEn <- map["emailSenderNameEn"]
//        emailSenderNameAr <- map["emailSenderNameAr"]
//        minPrice <- map["minPrice"]
//        maxPrice <- map["maxPrice"]
//    }
//    
//}




