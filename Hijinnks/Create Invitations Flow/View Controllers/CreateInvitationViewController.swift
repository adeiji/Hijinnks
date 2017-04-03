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
import FBSDKShareKit

class CreateInvitationViewController : UIViewController, PassDataBetweenViewControllersProtocol {
    weak var wrapperView:UIView! // This is so that we can have one view in which the Scroll View will have as it's indicator for scrolling
    weak var headerLabel:UILabel! // This label displays the short description for this page -- Create Invitation
    weak var nameTextField:UITextField!
    weak var locationTextField:UITextField!
    weak var inviteMessageTextField:UITextField!
    weak var startingTimeTextField:UITextField!
    weak var durationTextField:UITextField!
    weak var inviteesTextField:UITextField!
    weak var inviteInterestsTextField:UITextField! // Change this in production
    weak var maxNumberOfAttendeesTextField:UITextField!
    
    weak var scrollView:UIScrollView!
    
    weak var weeklyButton:UIButton!
    weak var monthlyButton:UIButton!
    
    var selectedInterests:Array<String>!
    var selectedFriends:NSArray!
    var name:String!
    var address:String!
    var locationCoordinates:CLLocation!
    var inviteMessage:String!
    var startingTime:Date!
    var duration:String!
    var place:GMSPlace!
    var durations:Array<String>!
    var delegate:PassDataBetweenViewControllersProtocol!
    var isPublic:Bool = false
    var invitationSendScope:InvitationSendScope!
    
    // These should be set to false by default.  User should have to set either of these values to true
    var isWeekly:Bool = false
    var isMonthly:Bool = false
    
    enum InvitationSendScope {
        case Everyone
        case AllFriends
        case SomeFriends
    }
    
    weak var selectedTextField:UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification: )), name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification: )), name: NSNotification.Name.UIKeyboardWillHide , object: nil)
        self.monthlyButton.addTarget(self, action: #selector(monthlyButtonPressed(_:)), for: .touchUpInside)
        self.weeklyButton.addTarget(self, action: #selector(weeklyButtonPressed(_:)), for: .touchUpInside)
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    // Dismiss the keyboard
    func dismissKeyboard () {
        self.view.endEditing(true)
    }
    
    func monthlyButtonPressed (_ sender: UIButton) {
        self.isMonthly = true
        self.isWeekly = false
        self.showRecurringButtonHighlighted(button: sender)
    }
    
    func weeklyButtonPressed (_ sender: UIButton) {
        self.isWeekly = true
        self.isMonthly = false
        self.showRecurringButtonHighlighted(button: sender)
    }
    
    func showRecurringButtonHighlighted (button: UIButton) {
        var otherButton:UIButton!
        
        if button == self.weeklyButton
        {
            otherButton = self.monthlyButton
        }
        else
        {
            otherButton = self.weeklyButton
        }
        
        button.backgroundColor = .white
        otherButton.backgroundColor = Colors.grey.value
        otherButton.setTitleColor(.black, for: .normal)
    }
    
    func reset () {
        setupUI()
        self.selectedInterests = nil
        self.selectedFriends = nil
        self.name = nil
        self.address = nil
        self.locationCoordinates = nil
        self.inviteMessage = nil
        self.startingTime = nil
        self.duration = nil
        self.place = nil
        self.durations = nil
        self.isPublic = true
        self.invitationSendScope = nil
        self.isWeekly = false
        self.isMonthly = false
    }
    
    func setRecurringView () {
        let recurringLabel = UILabel(text: "Would you like this to be a recurring event?")
        self.view.addSubview(recurringLabel)
        recurringLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.maxNumberOfAttendeesTextField.snp.bottom).offset(UIConstants.CreateInvitationVerticalSpacing.rawValue)
        }
        
        let weeklyButton = UIButton()
        weeklyButton.backgroundColor = Colors.grey.value
        weeklyButton.layer.borderWidth = 2
        weeklyButton.layer.borderColor = UIColor.black.cgColor
        weeklyButton.layer.cornerRadius = 5
        weeklyButton.setTitleColor(.black, for: .normal)
        weeklyButton.setTitle("Weekly", for: .normal)
        weeklyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.view.addSubview(weeklyButton)
        weeklyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(-100)
            make.width.equalTo(90)
            make.top.equalTo(recurringLabel.snp.bottom).offset(UIConstants.CreateInvitationVerticalSpacing.rawValue)
            make.height.equalTo(50)
        }
        
        let monthlyButton = UIButton()
        monthlyButton.backgroundColor = Colors.grey.value
        monthlyButton.layer.borderColor = UIColor.black.cgColor
        monthlyButton.layer.borderWidth = 2
        monthlyButton.layer.cornerRadius = 5
        monthlyButton.setTitle("Monthly", for: .normal)
        monthlyButton.setTitleColor(.black, for: .normal)
        monthlyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.view.addSubview(monthlyButton)
        monthlyButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view).offset(100)
            make.width.equalTo(90)
            make.top.equalTo(recurringLabel.snp.bottom).offset(UIConstants.CreateInvitationVerticalSpacing.rawValue)
            make.height.equalTo(50)
        }
        
        self.monthlyButton = monthlyButton
        self.weeklyButton = weeklyButton
    }
    
    func getRecurringButton () -> UIButton {
        return UIButton()
    }
    
    func setSelectedInterests(mySelectedInterest: Array<String>) {
        selectedInterests = mySelectedInterest
        var interestsString = String()
        
        for interest in selectedInterests {
            if interest != selectedInterests.last {
                interestsString += interest + ", "
            }
            else {
                interestsString += interest
            }
        }
        
        inviteInterestsTextField.text = interestsString
    }
    
    func setSelectedFriends(mySelectedFriends: NSArray) {
        self.selectedFriends = mySelectedFriends
        let selectedFriendsUserObjects = mySelectedFriends as! [PFUser]
        for user in selectedFriendsUserObjects {
            if user != selectedFriendsUserObjects.last {
                self.inviteesTextField.text = self.inviteesTextField.text! + "\(user.username!), "
            } else {
                self.inviteesTextField.text = self.inviteesTextField.text! + "\(user.username!)"
            }
        }
        self.invitationSendScope = InvitationSendScope.SomeFriends
    }
    
    func setSelectedFriendsToEveryone() {
        if PFUser.current()?.object(forKey: ParseObjectColumns.Friends.rawValue) != nil {
            self.selectedFriends = PFUser.current()?.object(forKey: ParseObjectColumns.Friends.rawValue) as! NSArray
            self.inviteesTextField.text = "All Your Friends"
            self.invitationSendScope = InvitationSendScope.AllFriends
        } else {
            // Inform the user that he is a loser and has no friends
            let alertController = UIAlertController(title: "No Friends", message: "Sorry, doesn't seem like you have any friends yet.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setSelectedFriendsToAnyone() {
        self.selectedFriends = [PFUser]() as NSArray!
        self.inviteesTextField.text = "Public to Anyone"
        self.invitationSendScope = InvitationSendScope.Everyone
        self.isPublic = true
    }
    
    func getLocation () -> PFGeoPoint! {
        // If the user did not select a place using the Google Maps Autocomplete feature, than we need to use his current location
        // So we need to get the current location from the Location Manager and than we need to get an address using the Lat/Long coordinates returned
        if self.place == nil {
            let locationManager = (UIApplication.shared.delegate as! AppDelegate).locationManager
            self.locationCoordinates = locationManager!.currentLocation
        
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.locationCoordinates, completionHandler: { (placemarks : [CLPlacemark]?, error: Error?) in
                let placemark = placemarks?.first
                let addressNumber = placemark?.subThoroughfare
                let address = placemark?.thoroughfare
                let city = placemark?.locality
                let state = placemark?.administrativeArea
                let zipCode = placemark?.postalCode
                
                let fullAddress = String("\(addressNumber!) \(address!), \(city!), \(state!) \(zipCode!)")
                self.address = fullAddress
                let location = PFGeoPoint(location: placemark?.location)
                self.saveAndSendInvitation(currentLocation: location)
            })
        }
        else {
            return PFGeoPoint(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        }
        
        return nil
    }
    
    func saveAndSendInvitation (currentLocation: PFGeoPoint) {
        // Check to make sure all the data entered is valid
        var invitees:NSArray!
        if validateTextFields() {
            if invitationSendScope == InvitationSendScope.SomeFriends // If the user has selected some friends
            {
                invitees = self.selectedFriends
                createInvitationAndSend(location: currentLocation, invitees: invitees as! Array<PFUser>)
            }
            else if invitationSendScope == InvitationSendScope.AllFriends { // If the user has selected all friends
                let query = PFUser.query()
                // Get all the Users that have ObjectIds stored on the device as friends object ids
                query?.whereKey(ParseObjectColumns.ObjectId.rawValue, containedIn: PFUser.current()?.object(forKey: ParseObjectColumns.Friends.rawValue) as! [Any])
                query?.findObjectsInBackground(block: { (friends, error) in
                    if (friends != nil) {
                        self.createInvitationAndSend(location: currentLocation, invitees: friends as! [PFUser])
                    }
                })
            }
            else {  // If the user has made the invitation public
                createInvitationAndSend(location: currentLocation, invitees: Array<PFUser>())
            }

            self.tabBarController?.selectedViewController = self.tabBarController?.viewControllers?.last
            self.promptPostToFacebook()
            self.reset()
        }
    }
    
    // Check to make sure that the information that needs to be entered is entered correctly
    func validateTextFields () -> Bool
    {
        if nameTextField.text == "" || self.address == nil || self.inviteMessageTextField.text == "" || self.startingTime == nil || self.durationTextField.text == nil || self.inviteesTextField.text == "" || self.selectedInterests == nil {
            
            let alertController = UIAlertController(title: "Invitation", message: "Please enter data into all fields", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    /**
     * - Description Create the invitation and than save on the server
     * - Parameter location CLLocation - The location that the user is currently at
     * - Parameter invitees Array<PFUser> - The array of PFUser(s) that the user has invited
     * - Returns nil
     */
    func createInvitationAndSend (location: PFGeoPoint, invitees: Array<PFUser>) {
        // Create an invitation object with all the specified data entered by the user
    
        
        let newInvitation = InvitationParseObject( eventName: self.nameTextField.text!,
                                                   location:  location,
                                                   address: self.address,
                                                   message: self.inviteMessageTextField.text!,
                                                   startingTime: self.startingTime!,
                                                   duration: self.durationTextField.text!,
                                                   invitees: invitees,
                                                   interests: self.selectedInterests,
                                                   fromUser: PFUser.current()!,
                                                   dateInvited: Date(),
                                                   rsvpCount: 0,
                                                   rsvpUsers: Array<String>(),
                                                   comments: Array<CommentParseObject>(),
                                                   isWeekly: self.isWeekly,
                                                   isMonthly: self.isMonthly,
                                                   maxAttendees: Int(self.maxNumberOfAttendeesTextField.text!)!,
                                                   isPublic: self.isPublic)
        
        ParseManager.save(parseObject: newInvitation) // Save the new invitation to the server
        // On the view invitations view controller, add this new invitation object
        delegate.addInvitation!(invitation: newInvitation)
        PFUser.current()?.incrementKey(ParseObjectColumns.InviteCount.rawValue)
        PFUser.current()?.saveInBackground()
    }
    
    // Ask the user if they would like to post the invitation to Facebook for others to see
    func promptPostToFacebook () {
        let alertController = UIAlertController(title: "Share", message: "Would you like to share this invitation to Facebook?", preferredStyle: .actionSheet)
        let postToFacebookAction = UIAlertAction(title: "Post to Facebook", style: .default) { (action) in
            self.postToFacebook()
        }
        let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
        alertController.addAction(postToFacebookAction)
        alertController.addAction(noAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Send an invitation to facebook users
    func postToFacebook () {
        let content = FBSDKShareLinkContent()
        content.contentTitle = self.name
        content.contentURL = NSURL(string: "http://hijinnks.com") as URL!
        content.contentDescription = self.inviteMessage
        FBSDKShareDialog.show(from: self, with: content, delegate: nil)
    }
    
    // Save the invitation to the server and update the View Invitations View Controller with the new invitation
    func sendInvite () {
        let location:PFGeoPoint! = getLocation()
        // If the location returns nil than that means that the invitations has already been created and saved to the server
        if location != nil {
            self.address = locationTextField.text
            saveAndSendInvitation(currentLocation: location)
        }
    }
    
    // Place all of the UI elements on screen
    func setupUI() {
        let sendButton = HijinnksButton(customButtonType: HijinnksViewTypes.SendButton)
        sendButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        sendButton.addTarget(self, action: #selector(sendInvite), for: .touchUpInside)
        let donebutton = UIBarButtonItem(customView: sendButton)
        self.navigationItem.rightBarButtonItem = donebutton
        self.view.backgroundColor = .white
        scrollView = createScrollView()
        scrollView.contentSize = scrollView.frame.size
        wrapperView = createWrapperView(myScrollView: scrollView)
        nameTextField = createTextField(superview: wrapperView, relativeViewAbove: nil, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Event Name", showViewController: nil, colorViewColor: Colors.green.value)
        
        locationTextField = createTextField(superview: wrapperView, relativeViewAbove: nameTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Leave Empty to Use Current Location", showViewController: nil, colorViewColor: Colors.blue.value)
        
        inviteMessageTextField = createTextField(superview: wrapperView, relativeViewAbove: locationTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Message", showViewController: nil, colorViewColor: Colors.green.value)
        
        startingTimeTextField = createTextField(superview: wrapperView, relativeViewAbove: inviteMessageTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Time", showViewController: nil, colorViewColor: Colors.blue.value)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        let date = NSDate.init() // gets me the current date and time
        datePicker.minimumDate = date as Date // make sure the minimum time they can choose is the current time
        datePicker.minuteInterval = 10
        startingTimeTextField.inputView = datePicker
        datePicker.addTarget(self, action: #selector(startTimePickerDateChanged(sender:)), for: .valueChanged)
        
        durationTextField = createTextField(superview: wrapperView, relativeViewAbove: startingTimeTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Duration", showViewController: nil, colorViewColor: Colors.grey.value)
        
        let selectFriendsViewController = SelectFriendsViewController()
        selectFriendsViewController.delegate = self
        
        inviteesTextField = createTextField(superview: wrapperView, relativeViewAbove: durationTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Who's Invited?", showViewController: nil, colorViewColor: Colors.green.value)
        
        inviteInterestsTextField = createTextField(superview: wrapperView, relativeViewAbove: inviteesTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing .rawValue, placeholderText: "Type of Invite", showViewController: nil, colorViewColor: Colors.blue.value)
        
        self.maxNumberOfAttendeesTextField = createTextField(superview: self.wrapperView, relativeViewAbove: inviteInterestsTextField, leftConstraintOffset: 0, rightConstraintOffset: 0, verticalSpacingToRelativeViewAbove: UIConstants.CreateInvitationVerticalSpacing.rawValue, placeholderText: "Max Attendees", showViewController: nil, colorViewColor: Colors.blue.value)
        self.maxNumberOfAttendeesTextField.keyboardType = .numberPad
        
        setupDurationTextFieldInputView()
        setRecurringView()
    }
    
    
    
    func createHeaderLabel () -> UILabel {
        let label = UILabel()
        label.text = "Create Invitation"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        self.view.addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view).offset(20)
        }
        
        return label
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
    
    // Scroll view which will basically act as our main view
    func createScrollView () -> UIScrollView {
        let myScrollView = UIScrollView()
        self.view.addSubview(myScrollView)
        myScrollView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(20)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
        
        return myScrollView
    }
    
    func createTextField (superview: UIView, relativeViewAbove: UIView!, leftConstraintOffset: Int, rightConstraintOffset: Int, verticalSpacingToRelativeViewAbove: Int, placeholderText: String, showViewController: UIViewController!, colorViewColor: UIColor) -> UITextField {
        let textField = UITextField()
        // The superview is the wrapper which contains all our elements within the scroll view
        superview.addSubview(textField)
        textField.textAlignment = .center
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [ NSForegroundColorAttributeName : UIColor.black ])
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 0.75
        textField.font = UIFont.systemFont(ofSize: 14)
        textField.backgroundColor = Colors.grey.value
        textField.delegate = self
    
        textField.snp.makeConstraints { (make) in
            make.left.equalTo(wrapperView).offset(UIConstants.HorizontalSpacingToSuperview.rawValue)
            make.right.equalTo(wrapperView).offset(-UIConstants.HorizontalSpacingToSuperview.rawValue)
            
            if relativeViewAbove == nil { // If there is no other view above this one than this is the view at the very top of the screen
                make.top.equalTo(wrapperView)
            }
            else {
                make.top.equalTo(relativeViewAbove.snp.bottom).offset(verticalSpacingToRelativeViewAbove)
            }
            make.height.equalTo(45)
        }
        
        return textField
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if self.selectedTextField != nil && textField == self.selectedTextField {
            self.selectedTextField = nil
            return false
        }
        
        return true
    }
    
    // When the text field is selected than change the color of the border
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
        if textField == locationTextField {
            let autocompleteViewController = GMSAutocompleteViewController()
            autocompleteViewController.delegate = self
            self.navigationController?.present(autocompleteViewController, animated: true, completion: nil)
        }
        else if textField == inviteInterestsTextField {
            let viewInterestsViewController = ViewInterestsViewController(setting: Settings.ViewInterestsCreateInvite, willPresentViewController: true)
            viewInterestsViewController.delegate = self
            viewInterestsViewController.wasPresented = true
            let navController = UINavigationController(rootViewController: viewInterestsViewController)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
        else if textField == inviteesTextField {
            let viewUsersViewController = ViewUsersViewController(setting: Settings.ViewUsersInvite, willPresentViewController: true)            
            viewUsersViewController.showSpecificUsers(userObjectIds: PFUser.current()?.value(forKey: ParseObjectColumns.Friends.rawValue) as? [String])
            viewUsersViewController.delegate = self
            let navController = UINavigationController(rootViewController: viewUsersViewController)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view
    }
}
// Handle the creation, source, and delegation for the duration text field
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
