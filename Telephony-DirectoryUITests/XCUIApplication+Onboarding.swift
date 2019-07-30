//  XCUIApplication
//
//  Created by Rathish Kannan on 30/07/19.
//  Copyright © 2019-20 Rathish Kannan. All rights reserved.
//

import XCTest

extension XCUIApplication {
    var isDisplayingOnboarding: Bool {
        return otherElements["contactListView"].exists
    }
}
