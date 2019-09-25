//
//  SocialMediaModels.swift
//  HomeMade2
//
//  Created by Apple on 17/05/2019.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

// MARK: - Facebook
struct FBData : Codable {
    let height : Int?
    let width : Int?
    let is_silhouette : Bool?
    let url : String?
    
}

struct FBPicture : Codable {
    let data : FBData?
}
struct FBUser : Codable {
    let first_name : String?
    let id : String?
    let last_name: String?
    let name : String?
    let email : String?
    let picture : FBPicture?
}

// MARK: - Google

// MARK: - Social
enum SocialMediaType {
    case Facebook
    case Google
    case Instagram
}

class SocialUser {
    
    var _id : String?
    var userName : String?
    var FullName : String?
    var FirstName : String?
    var LastName : String?
    var Email : String?
    var image : String?
    var accessToken : String?
    var authMethod : String{
        switch mediaType {
        case .Google?:
            return "google"
        case .Facebook?:
            return "facebook"
        case .Instagram?:
            return "instagram"
        default:
            return ""
        }
        
    }
    var mediaType : SocialMediaType?
    
    static func user(fbUser : FBUser?) -> SocialUser?{
        
        guard let fbUser = fbUser else{
            return nil
        }
        
        let user = SocialUser()
        user._id = fbUser.id
        user.userName = fbUser.name
        user.FirstName = fbUser.first_name
        user.LastName = fbUser.last_name
        user.FullName = fbUser.name
        user.Email = fbUser.email
        user.image = fbUser.picture?.data?.url
        user.accessToken = AccessToken.current?.tokenString
        
        user.mediaType = .Facebook
        return user
    }
    static func user(googleUser : GIDGoogleUser?) -> SocialUser?{
        
        
        guard let googleUser = googleUser else{
            return nil
        }
        
        let user = SocialUser()
        user._id = googleUser.userID
        user.userName = googleUser.profile.name
        user.FirstName = googleUser.profile.givenName
        user.LastName = googleUser.profile.familyName
//        user.FullName = googleUser.name
        user.Email = googleUser.profile.email
        user.accessToken = googleUser.authentication.accessToken
        
        if googleUser.profile.hasImage{
            user.image = googleUser.profile?.imageURL(withDimension: 400)?.absoluteString
        }
        user.mediaType = .Google
        
        return user
    }
}
class SocialLoginError {
    
    var reason : String?
    
}
