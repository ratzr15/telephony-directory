//
//  Quickseries.swift
//  Quickseries-API
//
//  Created by Thiago Magalhaes on 2019-05-17.
//  Copyright © 2019 Thiago Magalhaes. All rights reserved.
//

import Foundation
import Moya

enum Contacts {
    case getContacts
    case getDetail(id : String)
    case addContact(contact : ListCellViewModel)

}

extension Contacts : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://gojek-contacts-app.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getContacts: return "/contacts.json"
        case .getDetail(let id): return "/contacts/\(id).json"
        case .addContact( _): return "/contacts.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getContacts, .getDetail:
            return .get
        case  .addContact(_):
            return .post
        }
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "")!
    }
    
    var task: Task {
        switch self {
        case .getContacts, .getDetail:
            return .requestPlain
        case let .addContact(contact):
            return .requestParameters(parameters: ["id": contact.id,"first_name": contact.first_name, "last_name": contact.last_name, "email": contact.email ?? "", "phone_number": contact.phone ?? ""], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
