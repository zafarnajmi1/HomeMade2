//
//  API_List.swift
//  TailerOnline
//
//  Created by apple on 3/28/19.
//  Copyright © 2019 mytechnology. All rights reserved.
//

import Foundation

internal struct API {
    
    //used in BaseManager
    internal struct baseURL {
        
        static let dev =  "https://www.projects.mytechnology.ae/homemade/\(myDefaultLanguage)/api/"
        static let staging = ""
        static let production = ""
    }
    
    
}

internal enum Response<RootModel, Error> {
    case sucess(RootModel)
    case failure(Error)
}


internal enum UploadResponse<progress,completion,failure> {
    case progress(Double)
    case path(String)
    case failure(String)
}


//Auth module APIs

