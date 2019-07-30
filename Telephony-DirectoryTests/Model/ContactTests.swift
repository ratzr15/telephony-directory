//  ContactTests
//
//  Created by Rathish Kannan on 30/07/19.
//  Copyright © 2018 Rathish Kannan. All rights reserved.
//


import XCTest
@testable import Telephony_Directory

class ContactTests: XCTestCase {

    func testSuccessfulInit() {
        let testSuccessfulJSON: JSON = ["id": 1,
                                        "firstname": "Ratz",
                                        "lastname": "R15",
                                        "phonenumber": "0501234567"]
        XCTAssertNotNil(Contact.init(json: testSuccessfulJSON))
    }

}


