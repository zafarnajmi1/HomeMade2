//
//  HError.swift
//  Humminz
//
//  Created by mac on 8/3/18.
//  Copyright © 2018 sdsol. All rights reserved.
//

import UIKit

class HMSError {
    var errorCode:Int
    var errorMessage:String
    
    init(errorCode:Int, errorMessage:String) {
        self.errorCode = errorCode
        self.errorMessage = errorMessage
    }
}
