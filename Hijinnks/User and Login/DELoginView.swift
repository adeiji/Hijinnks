//  Converted with Swiftify v1.0.6274 - https://objectivec2swift.com/
//
//  DELoginView.swift
//  whatsgoinon
//
//  Created by adeiji on 8/8/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//
import UIKit
import FBSDKLoginKit

class DELoginView: UIView {
// MARK: - View Outlets
    // This view displays at the top of the login screen and simply displays the logo for the application
    weak var logoView:CustomHijinnksView!
    weak var txtUsernameOrEmail: UITextField!
    weak var txtPassword: UITextField!
    weak var signInButton: UIButton!
    weak var signUpButton: UIButton!
    weak var facebookLoginButton: UIButton!
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
        addImageToBackground()
        txtUsernameOrEmail = setupTextField(placeholder: "Username or Email", textFieldAbove : nil)
        txtPassword = setupTextField(placeholder: "Password", textFieldAbove: txtUsernameOrEmail)
        txtPassword.isSecureTextEntry = true
        errorLabel = setupErrorLabel()
        signInButton = setupSignInButton(title: "SIGN IN", viewObjectAbove: errorLabel)
        signUpButton = setupSignInButton(title: "SIGN UP", viewObjectAbove: signInButton)
        facebookLoginButton = setFacebookLoginButton(signUpButton: signUpButton)
    }
    
    func addImageToBackground () {
        let imageView = UIImageView(image: UIImage(named: Images.Background.rawValue))
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        imageView.layer.zPosition = -1
        
        let blackAlphaView = UIView()
        self.addSubview(blackAlphaView)
        blackAlphaView.backgroundColor = .black
        blackAlphaView.alpha = 0.35
        blackAlphaView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        blackAlphaView.layer.zPosition = -1
    }
    
    func setFacebookLoginButton (signUpButton: UIButton) -> UIButton {
        
        let myFacebookLoginButton = UIButton()
        myFacebookLoginButton.backgroundColor = Colors.FacebookButton.value
        myFacebookLoginButton.setTitleColor(.white, for: .normal)
        myFacebookLoginButton.setTitle("Login With Facebook", for: .normal)
        myFacebookLoginButton.layer.cornerRadius = 5
        self.addSubview(myFacebookLoginButton)
        myFacebookLoginButton.snp.makeConstraints { (make) in
            make.width.equalTo(signUpButton)
            make.height.equalTo(signUpButton)
            make.centerX.equalTo(signUpButton)
            make.top.equalTo(signUpButton.snp.bottom).offset(10)
        }
        
        return myFacebookLoginButton
        
    }
    
    // Display a sign in button below the password text field
    func setupSignInButton (title: String, viewObjectAbove: UIView!) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        
        self.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(viewObjectAbove.snp.bottom).offset(10)
            make.width.equalTo(self.txtPassword)
            make.centerX.equalTo(self)
            make.height.equalTo(self.txtPassword)
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
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                   attributes: [NSForegroundColorAttributeName: UIColor.white])
        textField.layer.cornerRadius = 5
        textField.textAlignment = .center
        textField.backgroundColor = Colors.AccountTextFieldColor.value
        textField.textColor = .white
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            if textFieldAbove == nil {
                make.top.equalTo(self.snp.bottom).offset(-340)
            }
            else {
                make.top.equalTo(textFieldAbove.snp.bottom).offset(10)
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
