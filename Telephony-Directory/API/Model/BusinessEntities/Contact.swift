import Foundation

typealias JSON = Dictionary<String, Any>

public struct Contact : Codable, Resource {
    public var id : Int?
	public var first_name : String?
	var last_name : String?
	var profile_pic : String?
	var favorite : Bool?
	var url : String?
    var phone_number : String?
    var email : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case first_name = "first_name"
		case last_name = "last_name"
		case profile_pic = "profile_pic"
		case favorite = "favorite"
		case url = "url"
        case phone_number = "phone_number"
        case email = "email"
	}

    public  init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
		last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
		profile_pic = try values.decodeIfPresent(String.self, forKey: .profile_pic)
		favorite = try values.decodeIfPresent(Bool.self, forKey: .favorite)
		url = try values.decodeIfPresent(String.self, forKey: .url)
        phone_number = try values.decodeIfPresent(String.self, forKey: .phone_number)
        email = try values.decodeIfPresent(String.self, forKey: .email)

	}

    init(json: JSON) {
        guard let id = json["id"] as? Int,
            let firstname = json["firstname"] as? String,
            let lastname = json["lastname"] as? String,
            let phonenumber = json["phonenumber"] as? String else {
                return
        }
        self.id = id
        self.first_name = firstname
        self.last_name = lastname
        self.phone_number = phonenumber
    }
    
}
