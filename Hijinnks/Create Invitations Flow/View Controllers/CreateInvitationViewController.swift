//
//  CreateInvitationViewController.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import GooglePlaces
import Parse

class CreateInvitationViewController : UIViewController, PassDataBetweenViewControllersProtocol {
    weak var wrapperView:UIView! // This is so that we can have one view in which the Scroll View will have as it's indicator for scrolling
    
    weak var nameTextField:UITextField!
    weak var locationTextField:UITextField!
    weak var detailsTextField:UITextField!
    weak var inviteMessageTextField:UITextField!
    weak var startingTimeTextField:UITextField!
    weak var durationTextField:UITextField!
    
    weak var inviteesTextField:UITextField!
    weak var inviteInterestsTextField:UITextField! // Change this in production
    weak var scrollView:UIScrollView!
    
    var selectedInterests:NSArray!
    var selectedFriends:NSArray!
    var name:String!
    var location:String!
    var details:String!
    var inviteMessage:String!
    var startingTime:Date!
    var duration:String!
    
    var place:GMSPlace!
    var durations:Array<String>!
    var delegate:PassDataBetweenViewControllersProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        self.tabBarItem = tabBarItem
        
        setupUI()
        self.navigationItem.title = "Hijinnks"
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    func setSelectedInterests(mySelectedInterest: NSArray) {
        selectedInterests = mySelectedInterest
        var interestsString = String()
        
        for interest in selectedInterests {
            if (interest as! String) != (selectedInterests.lastObject as! String) {
                interestsString += (interest as! String) + ", "
            }
            
            else {
                interestsString += (interest as! String)
            }
        }
        
        inviteInterestsTextField.text = interestsString
    }
    
    func setSelectedFriends(mySelectedFriends: NSArray) {
        selectedFriends = mySelectedFriends
    }
    
    func setSelectedFriendsToEveryone() {
        selectedFriends.adding(InviteesPresets.Everyone.rawValue)
    }
    
    // Save the invitation to the server
    func sendInvite () {
        
        let invitationLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        let mockUser = PFUser()
        mockUser.username = "Adebayo Ijidakinro"
        
        // Check to make sure all the data entered is valide
        // Create an invitation object with all the specified data entered by the user
        let newInvitation = Invitation(eventName: nameTextField.text!, location:  invitationLocation, details: detailsTextField.text, message: inviteMessageTextField.text, startingTime: self.startingTime, duration: durationTextField.text, invitees: nil, interests: selectedInterests as! Array<String>!, fromUser: mockUser)
        let newInvitationParseObject = newInvitation.getParseObject()
//        ParseManager.save(parseObject: newInvitationParseObject)
        delegate.addInvitation!(invitation: newInvitation)
        self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?.last
    }
    
    
    
    func setupUI() {
        let donebutton = UIBarButtonItem(title: "Send", style: .done, target: self, action: #selector(sendInvite))
        self.navigationItem.rightBarButtonItem = donebutton
        
        scrollView = createScrollView()
        scrollView.contentSize = self.view.frame.size
        
        wrapperView = createWrapperView(myScrollView: scrollView)
        
        nameTextField = createTextField(superview: wrapperView, relativeViewAbove: nil, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 5, placeholderText: "Enter the event name", showViewController: nil, colorViewColor: Colors.green.value)
        
        
        locationTextField = createTextField(superview: wrapperView,
                                            relativeViewAbove: nameTextField,
                                            leftConstraintOffset: 0,
                                            rightConstraintOffset: 0,
                                            verticalSpacingToRelativeViewAbove: 5,
                                            placeholderText: "Enter the location",
                                            showViewController: nil,
                                            colorViewColor: Colors.blue.value)
        
        detailsTextField = createTextField(superview: wrapperView,
                                           relativeViewAbove: locationTextField,
                                           leftConstraintOffset: 0,
                                           rightConstraintOffset: 0,
                                           verticalSpacingToRelativeViewAbove: 5,
                                           placeholderText: "Enter the Details",
                                           showViewController: nil,
                                           colorViewColor: Colors.grey.value)
        
        inviteMessageTextField = createTextField(superview: wrapperView,
                                                 relativeViewAbove: detailsTextField,
                                                 leftConstraintOffset: 0,
                                                 rightConstraintOffset: 0,
                                                 verticalSpacingToRelativeViewAbove: 5,
                                                 placeholderText: "Enter a message",
                                                 showViewController: nil,
                                                 colorViewColor: Colors.green.value)
        
        startingTimeTextField = createTextField(superview: wrapperView,
                                                relativeViewAbove: inviteMessageTextField,
                                                leftConstraintOffset: 0,
                                                rightConstraintOffset: 0,
                                                verticalSpacingToRelativeViewAbove: 5,
                                                placeholderText: "Enter a starting date and time",
                                                showViewController: nil,
                                                colorViewColor: Colors.blue.value)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let date = NSDate.init() // gets me the current date and time
        datePicker.minimumDate = date as Date // make sure the minimum time they can choose is the current time
        datePicker.minuteInterval = 10
        startingTimeTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(startTimePickerDateChanged(sender:)), for: .valueChanged)
        
        durationTextField = createTextField(superview: wrapperView,
                                            relativeViewAbove: startingTimeTextField,
                                            leftConstraintOffset: 0,
                                            rightConstraintOffset: 0,
                                            verticalSpacingToRelativeViewAbove: 5,
                                            placeholderText: "Enter a duration",
                                            showViewController: nil,
                                            colorViewColor: Colors.grey.value)
        
        let viewInterestsViewController = ViewInterestsViewController()
        let selectFriendsViewController = SelectFriendsViewController()
        selectFriendsViewController.delegate = self
        
        inviteesTextField = createTextField(superview: wrapperView,
                                            relativeViewAbove: durationTextField,
                                            leftConstraintOffset: 0,
                                            rightConstraintOffset: 0,
                                            verticalSpacingToRelativeViewAbove: 5,
                                            placeholderText: "Whom would you like to invite?",
                                            showViewController: nil,
                                            colorViewColor: Colors.green.value)
        
        inviteInterestsTextField = createTextField(superview: wrapperView,
                                          relativeViewAbove: inviteesTextField,
                                          leftConstraintOffset: 0,
                                          rightConstraintOffset: 0,
                                          verticalSpacingToRelativeViewAbove: 5,
                                          placeholderText: "What kind of invite is this?",
                                          showViewController: viewInterestsViewController,
                                          colorViewColor: Colors.blue.value)
        
        
        setupDurationTextFieldInputView()
    }
    
    
    // Whenever the user changes the date and the time the startingTimeTextField is updated with the selected information
    func startTimePickerDateChanged (sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let startDateAndTime = dateFormatter.string(from: sender.date)
        self.startingTime = sender.date
        startingTimeTextField.text = startDateAndTime
    }
    
    // This is the view that contains all the other subviews.  It acts as a wrapper so that the scroll view works correctly
    func createWrapperView (myScrollView: UIScrollView) -> UIView {
        let myWrapperView = UIView()
        myWrapperView.backgroundColor = .white
        myScrollView.addSubview(myWrapperView)
        myWrapperView.snp.makeConstraints { (make) in
            make.edges.equalTo(myScrollView)
            make.centerX.equalTo(myScrollView)
            make.width.equalTo(self.view)
            make.height.equalTo(self.view)
        }
        
        return myWrapperView
    }
    
    func createScrollView () -> UIScrollView {
        let myScrollView = UIScrollView()
        self.view.addSubview(myScrollView)
        myScrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        return myScrollView
    }
    
    func createTextField (superview: UIView, relativeViewAbove: UIView!, leftConstraintOffset: Int, rightConstraintOffset: Int, verticalSpacingToRelativeViewAbove: Int, placeholderText: String, showViewController: UIViewController!, colorViewColor: UIColor) -> UITextField {
        let textField = UITextField()
        superview.addSubview(textField)
        textField.textAlignment = .center
        textField.borderStyle = .none
        textField.placeholder = placeholderText
        textField.textColor = colorViewColor
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        textField.delegate = self
    
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(wrapperView)
            make.right.equalTo(wrapperView)
            
            if !(relativeViewAbove != nil) { // If there is no other view above this one than this is the view at the very top of the screen
                make.top.equalTo(wrapperView)
            }
            else {
                make.top.equalTo(relativeViewAbove.snp.bottom).offset(verticalSpacingToRelativeViewAbove)
            }
            make.height.equalTo(75)
        }
        
        return textField
    }
    
    // When the text field is selected than change the color of the border
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == locationTextField {
            let autocompleteViewController = GMSAutocompleteViewController()
            autocompleteViewController.delegate = self
            self.navigationController?.present(autocompleteViewController, animated: true, completion: nil)
        }
        else if textField == inviteInterestsTextField {
            let viewInterestsViewController = ViewInterestsViewController()
            viewInterestsViewController.delegate = self
            textField.resignFirstResponder()
            self.navigationController?.pushViewController(viewInterestsViewController, animated: true)
        }
        textField.layer.borderColor = textField.textColor?.cgColor
    }
    // When the text field loses focuses change the color of the border back to grey
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor.gray.cgColor
    }
}

extension CreateInvitationViewController : UIPickerViewDataSource, UIPickerViewDelegate {

    func setupDurationTextFieldInputView () {
        var durationOptions:Array<String> = Array<String>()
        for counter in 1...20 {
            durationOptions.append(String((counter * 10)) + " mins")
        }
        
        let durationPicker = UIPickerView()
        durationPicker.dataSource = self
        durationPicker.delegate = self
        durationTextField.inputView = durationPicker
        durations = durationOptions
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return durations[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        durationTextField.text = durations[row]
    }
    
}

class ColorView : UIControl {
    var textField:UITextField!
    var showViewController:UIViewController!
}
