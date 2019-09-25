

import Foundation 
//import ObjectMapper


//class User : NSObject, NSCoding, Mappable{
//
//    var id : String?
//    var accountType : String?
//    var address : String?
//    var addresses : [Addresses]?
//    var authorization : String?
//    var averageRating : Double?
//    var createdAt : String?
//    var descriptionField : String?
//    var descriptionAr : String?
//    var descriptionEn : String?
//    var email : String?
//    var facebook : ErrorModel?
//    var fcmTokens : [AnyObject]?
//    var gender : String?
//    var google : ErrorModel?
//    var image : String?
//    var isActive : Bool?
//    var isCartProcessing : Bool?
//    var isEmailVerified : Bool?
//    var language : ErrorModel?
//    var location : [Double]?
//    var paypalClientId : String?
//    var paypalSecretId : String?
//    var phone : String?
//    var products : [String]?
//    var role : RoleModel?
//    var storeName : String?
//    var storeNameAr : String?
//    var storeNameEn : String?
//    var updatedAt : String?
//    var verificationCode : String?
//    var firstName: String?
//    var lastName: String?
//
//    var fullName: String! {
//        get {
//            return "\(firstName ?? "") \(lastName ?? "")"
//        }
//    }
//    var isSeller: Bool {
//        get {
//            if accountType == "buyer" {
//                return false
//            }
//            else if accountType == "seller"{
//                return true
//            }
//            else{
//                return false
//            }
//
//
//        }
//    }
//
//
//
//    class func newInstance(map: Map) -> Mappable?{
//        return User()
//    }
//    required init?(map: Map){}
//    private override init(){}
//
//    func mapping(map: Map)
//    {
//        id <- map["_id"]
//        accountType <- map["accountType"]
//        address <- descriptionAr/        addresses <- map["addresses"]
//        authorization <- map["authorization"]
//        averageRating <- map["averageRating"]
//        createdAt <- map["createdAt"]
//        descriptionField <- map["description"]
//        descriptionAr <- map["descriptionAr"]
//        descriptionEn <- map["descriptionEn"]
//        email <- map["email"]
//        facebook <- map["facebook"]
//        fcmTokens <- map["fcmTokens"]
//        gender <- map["gender"]
//        google <- map["google"]
//        image <- map["image"]
//        isActive <- map["isActive"]
//        isCartProcedescriptionArCartProcessing"]
//        isEmailVerified <- map["isEmailVerified"]
//        language <- map["language"]
//        location <- map["location"]
//        paypalClientId <- map["paypalClientId"]
//        paypalSecretId <- map["paypalSecretId"]
//        phone <- map["phone"]
//        products <- map["products"]
//        role <- map["role"]
//        storeName <- map["storeName"]
//        storeNameAr <- map["storeNameAr"]
//        storeNameEn <- map["storeNameEn"]
//        updatedAt <- map["updatedAt"]
//        verificationCode <- map["verificationCode"]
//
//        firstName <- map["firstName"]
//        lastName <- map["lastName"]
//
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         id = aDecoder.decodeObject(forKey: "_id") as? String
//         accountType = aDecoder.decodeObject(forKey: "accountType") as? String
//         address = aDecoder.decodeObject(forKey: "address") as? String
//         addresses = aDecoder.decodeObject(forKey: "addresses") as? [Addresses]
//         authorization = aDecoder.decodeObject(forKey: "authorization") as? String
//         averageRating = aDecoder.decodeObject(forKey: "averageRating") as? Double
//         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
//         descriptionField = aDecoder.decodeObject(forKey: "description") as? String
//         descriptionAr = aDecoder.decodeObject(forKey: "descriptionAr") as? String
//         descriptionEn = aDecoder.decodeObject(forKey: "descriptionEn") as? String
//         email = aDecoder.decodeObject(forKey: "email") as? String
//         facebook = aDecoder.decodeObject(forKey: "facebook") as? ErrorModel
//         fcmTokens = aDecoder.decodeObject(forKey: "fcmTokens") as? [AnyObject]
//         gender = aDecoder.decodeObject(forKey: "gender") as? String
//         google = aDecoder.decodeObject(forKey: "google") as? ErrorModel
//         image = aDecoder.decodeObject(forKey: "image") as? String
//         isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
//         isCartProcessing = aDecoder.decodeObject(forKey: "isCartProcessing") as? Bool
//         isEmailVerified = aDecoder.decodeObject(forKey: "isEmailVerified") as? Bool
//         language = aDecoder.decodeObject(forKey: "language") as? ErrorModel
//         location = aDecoder.decodeObject(forKey: "location") as? [Double]
//         paypalClientId = aDecoder.decodeObject(forKey: "paypalClientId") as? String
//         paypalSecretId = aDecoder.decodeObject(forKey: "paypalSecretId") as? String
//         phone = aDecoder.decodeObject(forKey: "phone") as? String
//         products = aDecoder.decodeObject(forKey: "products") as? [String]
//         role = aDecoder.decodeObject(forKey: "role") as? RoleModel
//         storeName = aDecoder.decodeObject(forKey: "storeName") as? String
//         storeNameAr = aDecoder.decodeObject(forKey: "storeNameAr") as? String
//         storeNameEn = aDecoder.decodeObject(forKey: "storeNameEn") as? String
//         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
//         verificationCode = aDecoder.decodeObject(forKey: "verificationCode") as? String
//         firstName = aDecoder.decodeObject(forKey: "firstName") as? String
//         lastName = aDecoder.decodeObject(forKey: "lastName") as? String
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if id != nil{
//            aCoder.encode(id, forKey: "_id")
//        }
//        if accountType != nil{
//            aCoder.encode(accountType, forKey: "accountType")
//        }
//        if address != nil{
//            aCoder.encode(address, forKey: "address")
//        }
//        if addresses != nil{
//            aCoder.encode(addresses, forKey: "addresses")
//        }
//        if authorization != nil{
//            aCoder.encode(authorization, forKey: "authorization")
//        }
//        if averageRating != nil{
//            aCoder.encode(averageRating, forKey: "averageRating")
//        }
//        if createdAt != nil{
//            aCoder.encode(createdAt, forKey: "createdAt")
//        }
//        if descriptionField != nil{
//            aCoder.encode(descriptionField, forKey: "description")
//        }
//        if descriptionAr != nil{
//            aCoder.encode(descriptionAr, forKey: "descriptionAr")
//        }
//        if descriptionEn != nil{
//            aCoder.encode(descriptionEn, forKey: "descriptionEn")
//        }
//        if email != nil{
//            aCoder.encode(email, forKey: "email")
//        }
//        if facebook != nil{
//            aCoder.encode(facebook, forKey: "facebook")
//        }
//        if fcmTokens != nil{
//            aCoder.encode(fcmTokens, forKey: "fcmTokens")
//        }
//        if gender != nil{
//            aCoder.encode(gender, forKey: "gender")
//        }
//        if google != nil{
//            aCoder.encode(google, forKey: "google")
//        }
//        if image != nil{
//            aCoder.encode(image, forKey: "image")
//        }
//        if isActive != nil{
//            aCoder.encode(isActive, forKey: "isActive")
//        }
//        if isCartProcessing != nil{
//            aCoder.encode(isCartProcessing, forKey: "isCartProcessing")
//        }
//        if isEmailVerified != nil{
//            aCoder.encode(isEmailVerified, forKey: "isEmailVerified")
//        }
//        if language != nil{
//            aCoder.encode(language, forKey: "language")
//        }
//        if location != nil{
//            aCoder.encode(location, forKey: "location")
//        }
//        if paypalClientId != nil{
//            aCoder.encode(paypalClientId, forKey: "paypalClientId")
//        }
//        if paypalSecretId != nil{
//            aCoder.encode(paypalSecretId, forKey: "paypalSecretId")
//        }
//        if phone != nil{
//            aCoder.encode(phone, forKey: "phone")
//        }
//        if products != nil{
//            aCoder.encode(products, forKey: "products")
//        }
//        if role != nil{
//            aCoder.encode(role, forKey: "role")
//        }
//        if storeName != nil{
//            aCoder.encode(storeName, forKey: "storeName")
//        }
//        if storeNameAr != nil{
//            aCoder.encode(storeNameAr, forKey: "storeNameAr")
//        }
//        if storeNameEn != nil{
//            aCoder.encode(storeNameEn, forKey: "storeNameEn")
//        }
//        if updatedAt != nil{
//            aCoder.encode(updatedAt, forKey: "updatedAt")
//        }
//        if verificationCode != nil{
//            aCoder.encode(verificationCode, forKey: "verificationCode")
//        }
//        if firstName != nil{
//            aCoder.encode(firstName, forKey: "firstName")
//        }
//        if lastName != nil{
//            aCoder.encode(lastName, forKey: "lastName")
//        }
//    }
//
//}
class LoginAPIResponse : APIResponse{
    let data : User?
    private enum CodingKeys: String, CodingKey {
        case data = "data"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(User.self, forKey: .data)
        try super.init(from: decoder)
    }
}
struct Addresse : Codable {
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





struct User : Codable {
    let _id : String?
    let storeName : String?
    let description : String?
    let accountType : String?
    let products : [String]?
    let paypalClientId : String?
    let paypalSecretId : String?
    let phone : String?
    let address : String?
    let location : [Double]?
    let averageRating : Float?
    let gender : String?
    let image : String?
    let isCartProcessing : Bool?
    let isActive : Bool?
    let isEmailVerified : Bool?
    let verificationCode : String?
//    let balanceEarned : Price?
//    let currentBalance : Price?
//    let amountRefunded : Price?
    let amountRefundRequested : Bool?
    let email : String?
//    let role : Role?
    let addresses : [Addresse]?
    let canReviewUsers : [UserForReview]?
    let createdAt : String?
    let updatedAt : String?
    let descriptionEn : String?
    let descriptionAr : String?
    let storeNameEn : String?
    let storeNameAr : String?
    let language : [String : String]?
    let facebook : [String : String]?
    let google : [String : String]?
    let authorization : String?
    let firstName: String?
    let lastName: String?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case storeName = "storeName"
        case description = "description"
        case accountType = "accountType"
        case products = "products"
        case paypalClientId = "paypalClientId"
        case paypalSecretId = "paypalSecretId"
        case phone = "phone"
        case address = "address"
        case location = "location"
        case averageRating = "averageRating"
        case gender = "gender"
        case image = "image"
        case isCartProcessing = "isCartProcessing"
        case isActive = "isActive"
        case isEmailVerified = "isEmailVerified"
        case verificationCode = "verificationCode"
//        case balanceEarned = "balanceEarned"
//        case currentBalance = "currentBalance"
//        case amountRefunded = "amountRefunded"
        case amountRefundRequested = "amountRefundRequested"
        case email = "email"
//        case role = "role"
        case addresses = "addresses"
        case canReviewUsers = "canReviewUsers"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case descriptionEn = "descriptionEn"
        case descriptionAr = "descriptionAr"
        case storeNameEn = "storeNameEn"
        case storeNameAr = "storeNameAr"
        case language = "language"
        case facebook = "facebook"
        case google = "google"
        case authorization = "authorization"
        case firstName = "firstName"
        case lastName = "lastName"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        storeName = try values.decodeIfPresent(String.self, forKey: .storeName)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        accountType = try values.decodeIfPresent(String.self, forKey: .accountType)
        products = try values.decodeIfPresent([String].self, forKey: .products)
        paypalClientId = try values.decodeIfPresent(String.self, forKey: .paypalClientId)
        paypalSecretId = try values.decodeIfPresent(String.self, forKey: .paypalSecretId)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        location = try values.decodeIfPresent([Double].self, forKey: .location)
        averageRating = try values.decodeIfPresent(Float.self, forKey: .averageRating)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        isCartProcessing = try values.decodeIfPresent(Bool.self, forKey: .isCartProcessing)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        isEmailVerified = try values.decodeIfPresent(Bool.self, forKey: .isEmailVerified)
        verificationCode = try values.decodeIfPresent(String.self, forKey: .verificationCode)
//        balanceEarned = try values.decodeIfPresent(Price.self, forKey: .balanceEarned)
//        currentBalance = try values.decodeIfPresent(Price.self, forKey: .currentBalance)
//        amountRefunded = try values.decodeIfPresent(Price.self, forKey: .amountRefunded)
        amountRefundRequested = try values.decodeIfPresent(Bool.self, forKey: .amountRefundRequested)
        email = try values.decodeIfPresent(String.self, forKey: .email)
//        role = try values.decodeIfPresent(Role.self, forKey: .role)
        addresses = try values.decodeIfPresent([Addresse].self, forKey: .addresses)
        canReviewUsers = try values.decodeIfPresent([UserForReview].self, forKey: .canReviewUsers)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        descriptionEn = try values.decodeIfPresent(String.self, forKey: .descriptionEn)
        descriptionAr = try values.decodeIfPresent(String.self, forKey: .descriptionAr)
        storeNameEn = try values.decodeIfPresent(String.self, forKey: .storeNameEn)
        storeNameAr = try values.decodeIfPresent(String.self, forKey: .storeNameAr)
        language = try values.decodeIfPresent(Dictionary.self, forKey: .language)
        facebook = try values.decodeIfPresent(Dictionary.self, forKey: .facebook)
        google = try values.decodeIfPresent(Dictionary.self, forKey: .google)
        authorization = try values.decodeIfPresent(String.self, forKey: .authorization)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
    }
    
}

struct Role : Codable {
    let _id : String?
    let title : String?
    let roleType : String?
    let createdAt : String?
    let updatedAt : String?
    let permissions : Permissions?
    
    enum CodingKeys: String, CodingKey {
        
        case _id = "_id"
        case title = "title"
        case roleType = "roleType"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case permissions = "permissions"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        roleType = try values.decodeIfPresent(String.self, forKey: .roleType)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        updatedAt = try values.decodeIfPresent(String.self, forKey: .updatedAt)
        permissions = try values.decodeIfPresent(Permissions.self, forKey: .permissions)
    }
    
}
struct Permissions : Codable {
    

    var canPasswordChange : Bool?
    var canProfile : Bool?
    var canProfileUpdate : Bool?

    
    
    
    enum CodingKeys: String, CodingKey {
        
 
        case canProfile = "canProfile"
        case canProfileUpdate = "canProfileUpdate"
        case canPasswordChange = "canPasswordChange"
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        canProfile = try values.decodeIfPresent(Bool.self, forKey: .canProfile)
        canProfileUpdate = try values.decodeIfPresent(Bool.self, forKey: .canProfileUpdate)
        canPasswordChange = try values.decodeIfPresent(Bool.self, forKey: .canPasswordChange)
        
    }
    
}
struct UserForReview : Codable {
    
    
    var _id : String?
    var combination : String?
    var order : String?
    var orderDetail : String?
    var product : String?
    var store : String?
    var user : String?
    

    
    
    
    
    enum CodingKeys: String, CodingKey {
        
        
        case _id = "_id"
        case combination = "combination"
        case order = "order"
        case orderDetail = "orderDetail"
        case product = "product"
        case store = "store"
        case user = "user"
        
        
        
        
        
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        combination = try values.decodeIfPresent(String.self, forKey: .combination)
        order = try values.decodeIfPresent(String.self, forKey: .order)
        orderDetail = try values.decodeIfPresent(String.self, forKey: .orderDetail)
        product = try values.decodeIfPresent(String.self, forKey: .product)
        store = try values.decodeIfPresent(String.self, forKey: .store)
        user = try values.decodeIfPresent(String.self, forKey: .user)
        
        
    }
    
}
/*
 {
 "_id" = 5d0cd684aa32e10182eaaa24;
 combination = 5d0c8a88f6840611fccf3c53;
 order = 5d0ca5834dec8e555332cc66;
 orderDetail = 5d0ca5834dec8e555332cc6f;
 product = 5d0c8a88f6840611fccf3c4d;
 store = 5cee66af1ae3c22d1475ee32;
 user = 5ce77b0b5ca04d715d0ad39d;
 }
 */
