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

class CreateInvitationViewController : UIViewController, PassDataBetweenViewControllersProtocol {
    weak var wrapperView:UIView! // This is so that we can have one view in which the Scroll View will have as it's indicator for scrolling
    
    weak var nameTextField:UITextField!
    weak var locationTextField:UITextField!
    weak var detailsTextField:UITextField!
    weak var inviteMessageTextField:UITextField!
    weak var startingTimeTextField:UITextField!
    weak var durationTextField:UITextField!
    
    weak var inviteesTextField:UITextField!
    weak var inviteInterests:UITextField! // Change this in production
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        inviteInterests.text = interestsString
    }
    
    func setSelectedFriends(mySelectedFriends: NSArray) {
        selectedFriends = mySelectedFriends
    }
    
    func setSelectedFriendsToEveryone() {
        selectedFriends.adding(InviteesPresets.Everyone.rawValue)
    }
    
    // Save the invitation to the server
    func sendInvite () {
        name = nameTextField.text
        location = locationTextField.text
        details = detailsTextField.text
        inviteMessage = inviteMessageTextField.text
        duration = durationTextField.text
    }
    
    func setupUI() {
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(sendInvite))
        self.navigationItem.rightBarButtonItem = donebutton
        
        scrollView = createScrollView()
        scrollView.contentSize = self.view.frame.size
        
        wrapperView = createWrapperView(myScrollView: scrollView)
        
        nameTextField = createTextField(superview: wrapperView, relativeViewAbove: nil, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 5, placeholderText: "Enter the event name", showViewController: nil, colorViewColor: Colors.green.value)
        
        let autocompleteViewController = GMSAutocompleteViewController()
        autocompleteViewController.delegate = self
        locationTextField = createTextField(superview: wrapperView,
                                            relativeViewAbove: nameTextField,
                                            leftConstraintOffset: 0,
                                            rightConstraintOffset: 0,
                                            verticalSpacingToRelativeViewAbove: 5,
                                            placeholderText: "Enter the location",
                                            showViewController: autocompleteViewController,
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
        
        inviteInterests = createTextField(superview: wrapperView,
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
        textField.font = UIFont.boldSystemFont(ofSize: 14)
        
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
        
        addTextFieldColorView(textField: textField, color: colorViewColor, text: placeholderText, showViewController: showViewController)
        return textField
    }
    
    func addTextFieldColorView (textField: UITextField, color: UIColor, text: String, showViewController: UIViewController!) {
        
        let colorView = ColorView();
        colorView.backgroundColor = color
        wrapperView.addSubview(colorView)
        
        colorView.snp.makeConstraints { (make) in
            make.left.equalTo(wrapperView)
            make.top.equalTo(textField)
            make.right.equalTo(wrapperView)
            make.bottom.equalTo(textField)
        }
        colorView.textField = textField
        
        if showViewController != nil {
            colorView.showViewController = showViewController
        }
        
        colorView.addTarget(self, action: #selector(animateColorViewOpen(colorView:)), for: .touchUpInside)
        addLabelToColorView(text: text, colorView: colorView)
    }
    
    // When the user clicks on one of the Text Fields than we show an animation that displays the color on the TextField moving to the left, opening a way for the user to now enter in their text
    func animateColorViewOpen(colorView: ColorView) {
        
        // Push the view controller that is attached to the Color View Object onto the Nav stack.
        if colorView.showViewController != nil {
            if colorView.showViewController is ViewInterestsViewController {
                (colorView.showViewController as! ViewInterestsViewController).delegate = self
                self.navigationController?.pushViewController(colorView.showViewController, animated: true)
            }
            else if colorView.showViewController is GMSAutocompleteViewController { // If this is the view controller for selecting a location for the invite
                present(colorView.showViewController, animated: true, completion: nil)  // Display the Google Places Auto Completion Controller
            }
        }
        
        for subview in colorView.subviews {
            if subview is UILabel {
                subview.isHidden = true
            }
        }
        
        colorView.snp.updateConstraints({ (make) in
            make.right.equalTo(wrapperView).offset(-(self.view.frame.size.width - 10))
        })
        
        UIView.animate(withDuration: 0.75) {
            colorView.layoutIfNeeded()
        }
        
        colorView.textField.becomeFirstResponder()
    
    }
    
    func addLabelToColorView (text: String, colorView: UIView) {
        let label = UILabel()
        label.text = text
        
        colorView.addSubview(label)
        label.textColor = .white
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(colorView)
            make.centerY.equalTo(colorView)
        }
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
