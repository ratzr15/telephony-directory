//  OnboardingUITests
//
//  Created by Rathish Kannan on 30/07/19.
//  Copyright © 2019-20 Rathish Kannan. All rights reserved.
//

import XCTest

class OnboardingUITests: XCTestCase {
    var app: XCUIApplication!

    // MARK: - XCTestCase

    override func setUp() {
        super.setUp()

        // Since UI tests are more expensive to run, it's usually a good idea to exit if a failure was encountered
        continueAfterFailure = false

        app = XCUIApplication()

        // We send a command line argument to our app, to enable it to reset its state
        app.launchArguments.append("--uitesting")
    }

    // MARK: - Tests

    func testGoingThroughOnboarding() {
        app.launch()

        // Make sure we're displaying onboarding
        XCTAssertTrue(app.isDisplayingOnboarding)

        // Swipe up/ down three times to scroll through the contacts
        app.swipeDown()
        app.swipeUp()
        app.swipeDown()

        // Tap the "add" button to add contact
        app.buttons["Add"].tap()

        // Onboarding should no longer be displayed
        XCTAssertFalse(app.isDisplayingOnboarding)
    }
}
