
import Foundation 
import ObjectMapper


//class LoginAPIResponse : APIResponse{
//    let data : User1?
//
//
//    private enum CodingKeys: String, CodingKey {
//
//        case data = "data"
//
//    }
//
//    required init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        data = try values.decodeIfPresent(User1.self, forKey: .data)
//        try super.init(from: decoder)
//    }
//}
//class LoginResponse : NSObject, NSCoding, Mappable{
//
//    var data : User1?
//    var errors : ErrorModel?
//    var message : String?
//    var success : Bool?
//
//
//    class func newInstance(map: Map) -> Mappable?{
//        return LoginResponse()
//    }
//    required init?(map: Map){}
//    override init(){}
//
//    func mapping(map: Map)
//    {
//        data <- map["data"]
//        errors <- map["errors"]
//        message <- map["message"]
//        success <- map["success"]
//        
//    }
//
//    /**
//    * NSCoding required initializer.
//    * Fills the data from the passed decoder
//    */
//    @objc required init(coder aDecoder: NSCoder)
//    {
//         data = aDecoder.decodeObject(forKey: "data") as? User1
//         errors = aDecoder.decodeObject(forKey: "errors") as? ErrorModel
//         message = aDecoder.decodeObject(forKey: "message") as? String
//         success = aDecoder.decodeObject(forKey: "success") as? Bool
//
//    }
//
//    /**
//    * NSCoding required method.
//    * Encodes mode properties into the decoder
//    */
//    @objc func encode(with aCoder: NSCoder)
//    {
//        if data != nil{
//            aCoder.encode(data, forKey: "data")
//        }
//        if errors != nil{
//            aCoder.encode(errors, forKey: "errors")
//        }
//        if message != nil{
//            aCoder.encode(message, forKey: "message")
//        }
//        if success != nil{
//            aCoder.encode(success, forKey: "success")
//        }
//
//    }
//
//}
