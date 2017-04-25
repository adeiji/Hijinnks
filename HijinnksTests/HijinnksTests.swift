//
//  HijinnksTests.swift
//  HijinnksTests
//
//  Created by adeiji on 2/19/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import XCTest
import Parse
@testable import Hijinnks

class HijinnksTests: XCTestCase {
    
    var quickInviteView:QuickInviteView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // When the user presses public on the Quick Invite screen than isPublic must be true
    func quickInvitePublicButtonPressed () {
        let quickInviteController = QuickInviteController()
        quickInviteController.invitation.isPublic = false
        quickInviteController.publicButtonPressed()
        XCTAssertTrue()
    }
    
    // When the user presses All Friends on the Quick Invite page than isPublic must be false
    func quickInviteAllFriendsButtonPressed () {
        let quickInviteController = QuickInviteController()
        quickInviteController.invitation.isPublic = true
        quickInviteController.allFriendsButtonPressed()
        XCTAssertFalse()
    }
    
}
