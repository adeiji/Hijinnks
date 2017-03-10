//  Converted with Swiftify v1.0.6274 - https://objectivec2swift.com/
//
//  DELoginView.swift
//  whatsgoinon
//
//  Created by adeiji on 8/8/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//
import UIKit
class DELoginView: UIView {
// MARK: - View Outlets
    // This view displays at the top of the login screen and simply displays the logo for the application
    weak var logoView:CustomHijinnksView!
    weak var txtUsernameOrEmail: UITextField!
    weak var txtPassword: UITextField!
    weak var signInButton: UIButton!
    weak var signUpButton: UIButton!
    var nextScreen: UIViewController!
    weak var errorLabel: UILabel!
    
    func connect(withFacebook sender: Any) {
        
    }
    
    required init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        logoView = setLogoView()
        txtUsernameOrEmail = setupTextField(placeholder: "Username or Email", textFieldAbove : nil)
        txtPassword = setupTextField(placeholder: "Password", textFieldAbove: txtUsernameOrEmail)
        txtPassword.isSecureTextEntry = true
        errorLabel = setupErrorLabel()
        signInButton = setupSignInButton(title: "SIGN IN", viewObjectAbove: errorLabel)
        signUpButton = setupSignInButton(title: "SIGN UP", viewObjectAbove: signInButton)
    }
    
    // Display a sign in button below the password text field
    func setupSignInButton (title: String, viewObjectAbove: UIView!) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.setTitleColor(.gray, for: .normal)
        
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(viewObjectAbove.snp.bottom).offset(20)
            make.width.equalTo(UIConstants.SignUpAndSignInButtonWidth.rawValue)
            make.centerX.equalTo(self)
            make.height.equalTo(40)
        }
        
        return button
    }
    
    func setLogoView () -> CustomHijinnksView {
        let view = CustomHijinnksView(customViewType: .LogoView)
        view.backgroundColor = .white
        self.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(90)
            make.height.equalTo(40)
            make.width.equalTo(160)
            make.centerX.equalTo(self)
        }
        
        return view
    }
    
    func setupTextField (placeholder: String, textFieldAbove : UITextField!) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            if textFieldAbove == nil {
                make.top.equalTo(logoView.snp.bottom).offset(UIConstants.VerticalDistanceToLogo.rawValue)
            }
            else {
                make.top.equalTo(textFieldAbove.snp.bottom).offset(20)
            }
            make.left.equalTo(self).offset(UIConstants.HorizontalSpacingToSuperview.rawValue)
            make.right.equalTo(self).offset(-UIConstants.HorizontalSpacingToSuperview.rawValue)
            make.height.equalTo(45)
        }
        
        return textField
    }
    
    func setupErrorLabel () -> UILabel {
        let label = UILabel()
        self.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 12)
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(txtPassword)
            make.top.equalTo(txtPassword.snp.bottom).offset(20)
            make.width.equalTo(txtPassword)
        }
        
        return label
    }

    func removeFirstResponder() {
        // When the user taps the image, resign the first responder
        self.txtPassword.resignFirstResponder()
        self.txtUsernameOrEmail.resignFirstResponder()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.removeFirstResponder()   
    }
}

// Button Methods
extension DELoginView {
    
    func signUpButtonPressed () {
        DEUserManager.sharedManager.createUser(withUserName: txtUsernameOrEmail.text!, password: txtPassword.text!, email: txtUsernameOrEmail.text!, errorLabel: errorLabel)
    }
    
    func signInButtonPressed () {
        
    }
}
