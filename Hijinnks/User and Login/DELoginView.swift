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
    var nextScreen: UIViewController!
    weak var errorLabel: UILabel!


    @IBAction func connect(withFacebook sender: Any) {
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func setupUI () {
        logoView = setLogoView()
        txtUsernameOrEmail = setupTextField(placeholder: "Username or Email", textFieldAbove : nil)
        txtPassword = setupTextField(placeholder: "Password", textFieldAbove: txtUsernameOrEmail)
    }
    
    func setLogoView () -> CustomHijinnksView {
        let view = CustomHijinnksView(customViewType: .LogoView)
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(50)
            make.centerX.equalTo(self)
            make.height.equalTo(150)
            make.width.equalTo(view.snp.height)
        }
        
        return view
    }
    
    func setupTextField (placeholder: String, textFieldAbove : UITextField!) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeholder
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.gray.cgColor
        
        self.addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            if textFieldAbove == nil {
                make.top.equalTo(logoView.snp.bottom).offset(50)
            }
            else {
                make.top.equalTo(textFieldAbove.snp.bottom).offset(25)
            }
            make.left.equalTo(self).offset(45)
            make.right.equalTo(self).offset(45)
            make.height.equalTo(35)
        }
        
        return textField
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
