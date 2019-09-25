//
//  RattingReviewsModels.swift
//  HomeMade2
//
//  Created by Apple on 15/07/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class MyStoreRattingReviewsAPIResponse : APIResponse{
    
    let data : RattingReviewsResponse?
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RattingReviewsResponse.self, forKey: .data)
        try super.init(from: decoder)
    }
    
    
}

struct RattingReviewsResponse : Codable {
    let reviewsList : [StoreReview]?
    let reviewsCount : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case reviewsList = "collection"
        case reviewsCount = "reviewsTotalCount"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        reviewsList = try values.decodeIfPresent([StoreReview].self, forKey: .reviewsList)
        reviewsCount = try values.decodeIfPresent(Int.self, forKey: .reviewsCount)
    }
    
}

