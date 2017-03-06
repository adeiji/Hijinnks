//  Converted with Swiftify v1.0.6274 - https://objectivec2swift.com/
//
//  DECreateAccountView.swift
//  whatsgoinon
//
//  Created by adeiji on 8/8/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//
import UIKit
class DECreateAccountView: UIView, UITextFieldDelegate {
    weak var txtUsername: UITextField!
    weak var txtEmail: UITextField!
    weak var txtPassword: UITextField!
    weak var txtConfirmPassword: UITextField!
    weak var lblUsernameError: UILabel!
    weak var constraintConfirmPasswordToSignUpButton: NSLayoutConstraint!
    weak var constraintSignUpButtonToOrLabel: NSLayoutConstraint!
    weak var constraintOrLabelToLoginLabel: NSLayoutConstraint!
    weak var constraintLoginLabelToAccountButtons: NSLayoutConstraint!

    func setUp() {
        for view: UIView in self.subviews {
            if (view is UITextField) {
                let textField: UITextField? = (view as? UITextField)
                textField?.delegate = self
            }
        }
    }

    
    
    @IBAction func signUp(_ sender: Any) {
        
    }

    func setUpValidators() {

    }

    let ERROR_CODE_EMAIL_TAKEN = 203

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for view: UIView in self.subviews {
            if (view is UITextField) {
                view.resignFirstResponder()
            }
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
