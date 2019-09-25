
import Foundation 
import ObjectMapper


class RoleModel : NSObject, NSCoding, Mappable{

	var id : String?
	var createdAt : String?
	var permissions : PermissionModel?
	var roleType : String?
	var title : String?
	var updatedAt : String?


	class func newInstance(map: Map) -> Mappable?{
		return RoleModel()
	}
	required init?(map: Map){}
	private override init(){}

	func mapping(map: Map)
	{
		id <- map["_id"]
		createdAt <- map["createdAt"]
		permissions <- map["permissions"]
		roleType <- map["roleType"]
		title <- map["title"]
		updatedAt <- map["updatedAt"]
		
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
         permissions = aDecoder.decodeObject(forKey: "permissions") as? PermissionModel
         roleType = aDecoder.decodeObject(forKey: "roleType") as? String
         title = aDecoder.decodeObject(forKey: "title") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if permissions != nil{
			aCoder.encode(permissions, forKey: "permissions")
		}
		if roleType != nil{
			aCoder.encode(roleType, forKey: "roleType")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
