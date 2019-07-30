//
//  DetailViewModelTests
//  NewsListTests
//
//  Created by Rathish Kannan on 11/12/18.
//  Copyright © 2018 Rathish Kannan. All rights reserved.
//

import XCTest
import RxSwift
@testable import Telephony_Directory

class AddEditViewModelTests: XCTestCase {

    var api: ContactApi!
    
    override func setUp() {
        api = ContactApiClient.shared
    }

    override func tearDown() {
        api = nil
        
    }

    // MARK: - getContacts
    func testCellFormationForLists() {
        let disposeBag = DisposeBag()
        
        let viewModel = DetailViewModel.init()
        let contact = ListCellViewModel.with()
        

        viewModel.addResource(contact: contact)
        
        let expectNormalFriendCellCreated = expectation(description: "contacts contains a normal cell")
        
        viewModel.resources
            .flatMap({ return $0 == nil ? Observable.empty() : Observable.just($0!) })
            .subscribe { event in
                var firstCellIsNormal: Bool = false
                switch event {
                case .next( _):
                    firstCellIsNormal = true
                case .error(let error):
                    print(error)
                case .completed:
                    print("completed")
                }
                XCTAssertTrue(firstCellIsNormal)
                expectNormalFriendCellCreated.fulfill()
            }.disposed(by:disposeBag)
        
        wait(for: [expectNormalFriendCellCreated], timeout: 0.5)
    }
}
