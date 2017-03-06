//  Converted with Swiftify v1.0.6274 - https://objectivec2swift.com/
//
//  DELoginViewController.swift
//  whatsgoinon
//
//  Created by adeiji on 8/8/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//
import UIKit
import Parse

class DELoginViewController: UIViewController {
// MARK: - IBOutlets
    var buttons: [UIButton]!
    var textFields: [UITextField]!
    weak var lblLoginMessage: UILabel!
    weak var btnSkip: UIButton!
    weak var createAccountButtonToBottomConstraint: NSLayoutConstraint!
    weak var skipButtonToBottomConstraint: NSLayoutConstraint!
    var txtUsernameOrEmail: UITextField!
    var txtPassword: UITextField!
    weak var lblErrorLabel: UILabel!
    var backgroundView: UIView!
    var isAccount: Bool = false
    var isPosting: Bool = false
// MARK: - Button Press Methods

    @IBAction func createAnAccount(_ sender: Any) {
        
    }

    @IBAction func goBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func sign(in sender: Any) {
        let view: DELoginView? = (self.view as? DELoginView)
        let userManager = DEUserManager.sharedManager
        
        let nextViewController = UIViewController()
        _ = userManager.login(username: (view?.txtUsernameOrEmail?.text)!, password: (view?.txtPassword?.text)!, viewController: nextViewController, errorLabel: self.lblErrorLabel)
    }

    func skipLogin(_ sender: Any) {
    }

    let CREATE_ACCOUNT_VIEW_CONTROLLER = "createAccountViewController"
    let VIEW_RESTAURANTS_VIEW_CONTROLLER: String = "ViewRestaurantsViewController"
    let VIEW_RESTAURANTS_STORYBOARD: String = "ViewRestaurants"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.isAccount {
            self.btnSkip.isHidden = true
        }
        if self.isPosting {
            self.btnSkip.isHidden = true
            // Change the text to display that the user needs to login to post and then move the two visible buttons down.
            self.lblLoginMessage.text = "Posting an event to HappSnap is free but an account is required. It also only takes a few seconds and then you can get right to it."
            self.createAccountButtonToBottomConstraint.constant = self.skipButtonToBottomConstraint.constant
        }
        else {
            self.lblLoginMessage.text = "HappSnap is more fun and useful with an account.\n\nSign up in seconds for free!"
        }
        
        self.setTextFieldBorders()
        self.setUpCreateAccountView()
        
        PFUser.logOutInBackground()
    }

    func setUpCreateAccountView() {
        if (self.view is DECreateAccountView) {
            let view: DECreateAccountView? = (self.view as? DECreateAccountView)
            view?.txtPassword?.layer.borderColor = UIColor(red: CGFloat(203.0 / 255.0), green: CGFloat(80.0 / 255.0), blue: CGFloat(134.0 / 255.0), alpha: CGFloat(1.0)).cgColor
            view?.txtConfirmPassword?.layer.borderColor = UIColor(red: CGFloat(203.0 / 255.0), green: CGFloat(80.0 / 255.0), blue: CGFloat(134.0 / 255.0), alpha: CGFloat(1.0)).cgColor
            view?.txtUsername?.layer.borderColor = UIColor(red: CGFloat(76.0 / 255.0), green: CGFloat(161.0 / 255.0), blue: CGFloat(182.0 / 255.0), alpha: CGFloat(1.0)).cgColor
            view?.txtEmail?.layer.borderColor = UIColor(red: CGFloat(76.0 / 255.0), green: CGFloat(161.0 / 255.0), blue: CGFloat(182.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        }
    }
    // Set the border colors of the text boxes

    func setTextFieldBorders() {
        let view:DELoginView = (self.view as! DELoginView)
        view.txtPassword?.layer.borderColor = UIColor(red: CGFloat(203.0 / 255.0), green: CGFloat(80.0 / 255.0), blue: CGFloat(134.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        view.txtUsernameOrEmail?.layer.borderColor = UIColor(red: CGFloat(76.0 / 255.0), green: CGFloat(161.0 / 255.0), blue: CGFloat(182.0 / 255.0), alpha: CGFloat(1.0)).cgColor
        view.txtPassword?.layer.borderWidth = 1.0
        view.txtUsernameOrEmail?.layer.borderWidth = 1.0
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.spinView()
    }
//#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

    func spinView() {
        UIView.animate(withDuration: 40.0, delay: 0.0, options: .curveLinear, animations: {() -> Void in
            self.backgroundView.transform = self.backgroundView.transform.rotated(by: .pi / 2)
        }, completion: {(_ finished: Bool) -> Void in
            if finished {
                // if flag still set, keep spinning with constant speed
                self.spinView()
            }
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.isHidden = true
    }
// MARK: - Button Press Methods
// MARK: - Button Methods

    @IBAction func signUp(_ sender: Any) {
        let view: DECreateAccountView? = (self.view as? DECreateAccountView)
        view?.setUpValidators()
        // Check to see if the data entered was correc first
        _ = DEUserManager.sharedManager.createUser(withUserName: (view?.txtUsername?.text)!, password: (view?.txtPassword?.text)!, email: (view?.txtEmail?.text)!, errorLabel: (view?.lblUsernameError)!)
    
    }

    @IBAction func login(withFacebook sender: Any) {
        _ = DEUserManager.sharedManager.loginWithFacebook()
    }
}
