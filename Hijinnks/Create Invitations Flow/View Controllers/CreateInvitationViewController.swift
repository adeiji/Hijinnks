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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
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
        
        nameTextField = createTextField(superview: wrapperView, relativeViewAbove: nil, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter the event name", showViewController: nil, colorViewColor: Colors.green.value)
        
        locationTextField = createTextField(superview: wrapperView, relativeViewAbove: nameTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter the location", showViewController: nil, colorViewColor: Colors.blue.value)
        
        detailsTextField = createTextField(superview: wrapperView, relativeViewAbove: locationTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter the Details", showViewController: nil, colorViewColor: Colors.grey.value)
        
        inviteMessageTextField = createTextField(superview: wrapperView, relativeViewAbove: detailsTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter a message", showViewController: nil, colorViewColor: Colors.green.value)
        
        startingTimeTextField = createTextField(superview: wrapperView, relativeViewAbove: inviteMessageTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter a starting date and time", showViewController: nil, colorViewColor: Colors.blue.value)
        
        durationTextField = createTextField(superview: wrapperView, relativeViewAbove: startingTimeTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Enter a duration", showViewController: nil, colorViewColor: Colors.grey.value)
        
        let tempVC = UIViewController()
        let viewInterestsViewController = ViewInterestsViewController()
        
        inviteesTextField = createTextField(superview: wrapperView, relativeViewAbove: durationTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "Whom would you like to invite?", showViewController: tempVC, colorViewColor: Colors.green.value)
        
        inviteInterests = createTextField(superview: wrapperView, relativeViewAbove: inviteesTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: 10, placeholderText: "What kind of invite is this?", showViewController: viewInterestsViewController, colorViewColor: Colors.blue.value)
        
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
        
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(wrapperView)
            make.right.equalTo(wrapperView)
            
            if !(relativeViewAbove != nil) { // If there is no other view above this one than this is the topmost view
                make.top.equalTo(wrapperView)
            }
            else {
                make.top.equalTo(relativeViewAbove.snp.bottom).offset(verticalSpacingToRelativeViewAbove)
            }
            make.height.equalTo(50)
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
            if colorView.showViewController is ViewInterestsViewController
            {
                (colorView.showViewController as! ViewInterestsViewController).delegate = self
            }
            self.navigationController?.pushViewController(colorView.showViewController, animated: true)
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

class ColorView : UIControl {
    var textField:UITextField!
    var showViewController:UIViewController!
}
