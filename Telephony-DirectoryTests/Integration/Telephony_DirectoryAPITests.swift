//  Telephony_DirectoryAPITests
//
//  Created by Rathish Kannan on 30/07/19.
//  Copyright © 2018 Rathish Kannan. All rights reserved.
//


import XCTest
@testable import Telephony_Directory

class Telephony_DirectoryAPITests: XCTestCase {

    var api: ContactApi!

    var stubID: String  = "8256"
    
    override func setUp() {
        api = ContactApiClient.shared
    }

    override func tearDown() {
        api = nil
        
    }

    func testIntegrationGetContacts() {
        let expectation = self.expectation(description: "Request Finished")
        var response: Outcome<[Telephony_Directory.Contact]>?
        api.getContacts() { outcome in
            response = outcome
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(response)
        switch response {
        case .success(let results)?:
            stubID = String(results[0].id ?? 8256)
            XCTAssert(results.count > 0)
        case .failure(let error, _)?:
            XCTAssert(false, error.localizedDescription)
        case .none:
            XCTAssert(false)
        }
    }
    
    func testIntegrationGetDetailOfContact() {
        let expectation = self.expectation(description: "Request Finished")
        var response: Outcome<[Telephony_Directory.Contact]>?
        api.getDetail(id: stubID) { outcome in
            response = outcome
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(response)
        switch response {
        case .success(let results)?:
             XCTAssert(stubID.contains(String(results[0].id ?? 0)))
             XCTAssert(results.count > 0)
        case .failure(let error, _)?:
            XCTAssert(false, error.localizedDescription)
        case .none:
            XCTAssert(false)
        }
    }
    
    func testIntegrationAddContact() {
        let expectation = self.expectation(description: "Request Finished")
        var response: Outcome<[Telephony_Directory.Contact]>?
        api.addContact(contact: ListCellViewModel.init(id: 1001999, first_name: "Amitab", last_name: " Test Case Engineer", isFavorite: true, profile_pic: "https://contacts-app.s3-ap-southeast-1.amazonaws.com/contacts/profile_pics/000/000/007/original/ab.jpg?1464516610")) { outcome in
            response = outcome
            expectation.fulfill()
        }
        waitForExpectations(timeout: 3.0, handler: nil)
        XCTAssertNotNil(response)
        switch response {
        case .success(let results)?:
            XCTAssert(results[0].first_name == "Amitab")
        case .failure(let error, _)?:
            XCTAssert(false, error.localizedDescription)
        case .none:
            XCTAssert(false)
        }
    }

    func testPerformanceOfGetContacts() {
        self.measure {
           self.testIntegrationGetContacts()
        }
    }

}
