//  Converted with Swiftify v1.0.6274 - https://objectivec2swift.com/
//
//  DEUserManager.swift
//  whatsgoinon
//
//  Created by adeiji on 8/8/14.
//  Copyright (c) 2014 adeiji. All rights reserved.
//
import Foundation
import Parse

private let sharedUserManager = DEUserManager()

class DEUserManager: NSObject {
    let PARSE_CLASS_USERNAME = "username"
    let PARSE_CLASS_USER_RANK = "rank"
    let PARSE_CLASS_USER_CANONICAL_USERNAME = "canonical_username"
    let USER_RANK_STANDARD = "standard"
    let PARSE_CLASS_USER_PROFILE_PICTURE = "profile_picture"
    var delegate:PassDataBetweenViewControllersProtocol!
    
    func createUser(withUserName userName: String, password: String, email: String, errorLabel label: UILabel, showViewControllerOnComplete: UIViewController) {
        self.user = PFUser()
        self.user.username = userName.lowercased()
        self.user.password = password
        self.user.email = email
        
        self.user.signUpInBackground(block: {(_ succeeded: Bool, _ error: Error?) -> Void in
            if error == nil {
                self.userObject = self.user
                self.userObject[self.PARSE_CLASS_USER_RANK] = self.USER_RANK_STANDARD
                self.userObject[self.PARSE_CLASS_USER_CANONICAL_USERNAME] = userName
                self.userObject.saveEventually()
                
                let appDelegate = UIApplication.shared.delegate
                let navigationController = appDelegate?.window!?.rootViewController as! UINavigationController
                navigationController.pushViewController(showViewControllerOnComplete, animated: true)
            }
            else {
                label.isHidden = false
                label.text = error?.localizedDescription
            }
        })        
    }

    func login(username: String, password: String, viewController: UIViewController, errorLabel: UILabel) -> Error? {
        let lowercaseUsername = username.lowercased()
        var blockUsername: String = username
            // Get the user corresponding to an email and then use that username to login
        let query: PFQuery? = PFUser.query()
        query?.whereKey(self.PARSE_CLASS_USERNAME, equalTo: lowercaseUsername)
        query?.getFirstObjectInBackground(block: { (obj, error) in
            // If there's no returned objects we know then that this email does not exist, if we get a returned object though, we want to get that username and login now
            blockUsername = obj?.object(forKey: self.PARSE_CLASS_USERNAME) as! String
            
            PFUser.logInWithUsername(inBackground: blockUsername, password: password, block: { (user, error) in
                if self.user != nil {
                    // Clear user image defaults
                    self.clearUserImageDefaults()
                    _ = self.isLoggedIn()
                    
                    // Get all the users friends if they have any
                    if self.user.object(forKey:ParseObjectColumns.Friends.rawValue) != nil {
                        for friend in self.user.object(forKey: ParseObjectColumns.Friends.rawValue) as! [PFObject] {
                            friend.fetchIfNeededInBackground()
                        }
                    }
                }
                else {
                    _ = self.usernameExist(blockUsername.lowercased(), errorLabel: errorLabel)
                }
            })
        })
        return nil
    }
    /*
     
     Change the password of the current user
     password: The new password
     
     */

    func changePassword(_ password: String) {
        PFUser.current()?.password = password
        PFUser.current()?.saveInBackground(block: {(_ succeeded: Bool, _ error: Error?) -> Void in
            if succeeded {
                print("Password Changed Succesfully and Saved to Server")
            }
        })
    }

    func isLoggedIn() -> Bool {
        let currentUser = PFUser.current()
        if currentUser != nil {
            self.user = currentUser
            let userQuery: PFQuery? = PFUser.query()
            userQuery?.whereKey(PARSE_CLASS_USERNAME, equalTo: currentUser?.username as Any) // Get the user from the server with the specified username
            userQuery?.findObjectsInBackground(block: { (objects, error) in
                if error == nil {
                    self.userObject = self.user
                    let imageFile: PFFile? = (self.user[self.PARSE_CLASS_USER_PROFILE_PICTURE] as? PFFile)
                    imageFile?.getDataStreamInBackground(block: { (data, error) in
                        
                    })
                }
            })
            return true
        }
        else {
            return false
        }
    }

    
    class var sharedManager : DEUserManager {
        return sharedUserManager
    }

    func loginWithFacebook() -> Error? {
        return nil
    }

    func isLinkedWithFacebook() -> Bool {
        return false
    }

    func saveItem(toArray item: String, parseColumnName columnName: String) {
        PFUser.current()?.add(item, forKey: columnName)
        PFUser.current()?.saveInBackground(block: {(_ succeeded: Bool, _ error: Error?) -> Void in
            if succeeded {
                print("Yeah!! You saved the item to an array on parse!")
            }
            else {
                print("Uh oh, something happened and the item didn't save to the array")
            }
        })
    }

    func addProfileImage(_ profileImageData: Data) {
        let myUser: PFObject? = PFUser.current()
        let imageFile = PFFile(data: profileImageData)
        myUser?.setObject(imageFile as Any, forKey: self.PARSE_CLASS_USER_PROFILE_PICTURE)
        
        myUser?.saveInBackground(block: {(_ succeeded: Bool, _ error: Error?) -> Void in
            if error == nil {
                print("Sweet! The profile picture saved")
                let userDefaults = UserDefaults.standard
                userDefaults.set(profileImageData, forKey: "profile-picture")
                userDefaults.synchronize()
            }
            else {
                // Error saving the profile picture
            }
        })
    }

    func getUserRank(_ username: String) {
        let query: PFQuery? = PFUser.query()
        query?.whereKey(self.PARSE_CLASS_USERNAME, equalTo: username)
        query?.getFirstObjectInBackground(block: { (object, error) in
            if object != nil {
                if ((object?.object(forKey: self.PARSE_CLASS_USER_RANK)) != nil) {
                    // Set the user rank
                }
                else {
                    // The user has no ranking yet
                }
            }
        })
    }

    // Given a username, retrieve the actual user object
    class func getUserFromUsername(_ username: String) {
//        var query: PFQuery? = PFUser.query
//        if username != "" {
//            query?.whereKey(PARSE_CLASS_USER_USERNAME, equalTo: username)
//            query?.findObjectsInBackground(withBlock: {(_ objects: [Any], _ error: Error?) -> Void in
//                if objects.count > 0 {
//
//                }
//            })
//        }
    }
    var user: PFUser!
    var userObject: PFObject!

    static let FACEBOOK_USER_LOCATION: String = "location"
    static let FACEBOOK_USER_LOCATION_NAME: String = "name"
    static let TWITTER_USER_LOCATION: String = "location"

    override init() {
        super.init()

        if nil == self.user {
            self.user = PFUser.current()
        }
    
    }
    // Check to see if there is a current user logged in and returns the result
//- May not be necessary
    // Each user has its own rank.  This gets the rank of the current user from Parse.
    /*
     
     Change the password of the current user
     password: The new password
     
     */
    // Set the user as standard.

    func setUserRankToStandard() {
        let query: PFQuery? = PFUser.query()
        query?.whereKey(PARSE_CLASS_USERNAME, equalTo: (PFUser.current()?.username)! as String)
        query?.getFirstObjectInBackground(block: { (object, error) in
            if object == nil {
                object?[self.PARSE_CLASS_USER_RANK] = self.USER_RANK_STANDARD
                object?.saveEventually()
            }
        })
    }
    //Save an item to an array on parse.
    //It is essential that whatever the column
    //the user is saving is be an array,
    //otherwise this will not work properly.

    func clearUserImageDefaults() {
        let userDefaults = UserDefaults.standard
        userDefaults.set(nil, forKey: "profile-picture")
        userDefaults.synchronize()
    }

    func usernameExist(_ username: String, errorLabel label: UILabel) -> Bool {
//        var query: PFQuery? = PFUser.query
//        query?.whereKey(PARSE_CLASS_USER_USERNAME, equalTo: username.lowercased())
//        query?.findObjectsInBackground(withBlock: {(_ objects: [Any], _ error: Error?) -> Void in
//            if objects.count > 0 {
//                label.text = "Incorrect password"
//            }
//            else {
//                label.text = "Username does not exist"
//            }
//            label.isHidden = false
//        })
        return false
    }

    func addLocation(toUserCity city: String, state: String) {
//        PFUser.current()[PARSE_CLASS_USER_CITY] = city
//        PFUser.current()[PARSE_CLASS_USER_STATE] = state
//        PFUser.current().saveEventually({(_ succeeded: Bool, _ error: Error?) -> Void in
//            if error == nil {
//                print("The location of the user was pulled from the social network and stored in the database")
//            }
//            else {
//                print("Error storing the users location")
//            }
//        })
    }
    // Get the Facebook Profile Picture

    func getFacebookProfileInformation() {
    }
}
