//
//  CreateAccountViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/9/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CreateAccountViewController : UIViewController, PassDataBetweenViewControllersProtocol {
    
    var createAccountView:DECreateAccountView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createAccountView = DECreateAccountView()
        self.view.addSubview(createAccountView)
        createAccountView.setupUI()
        createAccountView.signupButton.addTarget(self, action: #selector(signupButtonPressed), for: .touchUpInside)
    }
    
    func signupButtonPressed () {
        let username = createAccountView.txtUsername.text
        let password = createAccountView.txtPassword.text
        let email = createAccountView.txtEmail.text
        
        let viewInterestsViewController = ViewInterestsViewController(setting: Settings.ViewInterestsCreateAccountOrChangeInterests)
        viewInterestsViewController.delegate = self
        viewInterestsViewController.showExplanationView()
        // Create user and then display the view interests view controller upon success
        DEUserManager.sharedManager.createUser(withUserName: username!, password: password!, email: email!, errorLabel: createAccountView.lblUsernameError, showViewControllerOnComplete: viewInterestsViewController)
    }
    
    func setSelectedInterests(mySelectedInterest: NSArray) {
        PFUser.current()?.setObject(mySelectedInterest as! [String], forKey: ParseObjectColumns.Interests.rawValue)
        // Once the user has selecte the interests that he wants than we show the main tab controller
        let tabBarController = MainTabBarController()
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window!?.rootViewController = tabBarController
    }
    
}
