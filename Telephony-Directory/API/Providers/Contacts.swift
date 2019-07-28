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
    case getReviews
}

extension Contacts : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://gojek-contacts-app.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .getReviews: return "/contacts.json"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return Data(base64Encoded: "")!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
