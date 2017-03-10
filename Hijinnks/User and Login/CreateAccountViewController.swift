//
//  CreateAccountViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/9/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

class CreateAccountViewController : UIViewController {
    
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
        
        // Create user and then display the view invitations view controller upon success
        DEUserManager.sharedManager.createUser(withUserName: username!, password: password!, email: email!, errorLabel: createAccountView.lblUsernameError)
    }
    
}
