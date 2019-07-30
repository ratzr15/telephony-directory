//
//  Contact
//  Contact
//

import Foundation
@testable import Telephony_Directory

extension Contact {
    static func with(json: JSON = ["id": 1,
                                   "firstname": "Ratz",
                                   "lastname": "R15",
                                   "phonenumber": "0501234567"] ) -> Contact {
        return Contact.init(json: json)
    }
}


extension ListCellViewModel {
    static func with(json: JSON = ["id": 1,
                                   "firstname": "Ratz",
                                   "lastname": "R15",
                                   "phonenumber": "0501234567"] ) -> ListCellViewModel {
        return ListCellViewModel.init(id: 9001, first_name: "GoJek", last_name: "Test Case Engineer", isFavorite: true, profile_pic: "")
    }
}
