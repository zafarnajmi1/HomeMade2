

import Foundation 
import ObjectMapper


class PermissionModel : NSObject, NSCoding, Mappable{

	var canPasswordChange : Bool?
	var canProfile : Bool?
	var canProfileUpdate : Bool?


	class func newInstance(map: Map) -> Mappable?{
		return PermissionModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		canPasswordChange <- map["canPasswordChange"]
		canProfile <- map["canProfile"]
		canProfileUpdate <- map["canProfileUpdate"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         canPasswordChange = aDecoder.decodeObject(forKey: "canPasswordChange") as? Bool
         canProfile = aDecoder.decodeObject(forKey: "canProfile") as? Bool
         canProfileUpdate = aDecoder.decodeObject(forKey: "canProfileUpdate") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if canPasswordChange != nil{
			aCoder.encode(canPasswordChange, forKey: "canPasswordChange")
		}
		if canProfile != nil{
			aCoder.encode(canProfile, forKey: "canProfile")
		}
		if canProfileUpdate != nil{
			aCoder.encode(canProfileUpdate, forKey: "canProfileUpdate")
		}

	}

}
