//
//  CommonModels.swift
//  HomeMade2
//
//  Created by Apple on 17/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit


class UnseenNotificationRespons : APIResponse {
    var data : UnseenNotification?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        
        let containter = try decoder.container(keyedBy: CodingKeys.self)
        data = try containter.decodeIfPresent(UnseenNotification.self, forKey: .data)
        //        let superDecoder = try containter.superDecoder()
        try super.init(from: decoder)
    }
}

struct UnseenNotification : Codable {
    var unseenNotificationsCount : Int?
}


//{
//    "data" : {
//        "unseenNotificationsCount" : 0
//    },
//    "errors" : {
//
//    },
//    "message" : "OK",
//    "success" : true
//}
