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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func isCameraAvailable () {
        let createAccountViewController = CreateAccountViewController()
        let photoHandler = PhotoHandler(viewController: createAccountViewController)
        XCTAssertEqual(photoHandler.viewController, createAccountViewController)
    }
    
    func setProfileImageView () {
        let profileViewController = ProfileViewController()
        let user = PFUser()
        profileViewController.profileView = ProfileView(myUser: user, myTableViewDataSourceAndDelegate: profileViewController)
        profileViewController.profileView.setupUI()
        let gestureRecognizersCount = profileViewController.profileView.profileImageView.gestureRecognizers?.count
        XCTAssertGreaterThan(gestureRecognizersCount, 0) // There should be a tap gesture recognizer so that the user can tap the image in order to add or edit one
    }
    
    func setupConversationViewUI () {
        let conversationViewController = ConversationViewController()
        let conversationView = ConversationView()
        XCTAssertNotEqual(conversationViewController.users, nil)
        conversationView.setupUI()
        
    }
    
}
