//
//  DEUserManager+PFUser.swift
//  Hijinnks
//
//  Created by adeiji on 4/2/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import Parse

extension DEUserManager {
    
    /**
     * - Description Get a list of all the friends user objects
     * - Parameter The user of which to get the friends from
     * - Returns [String] - The list of friends' object ids
     ```
        DEUserManager.sharedManager.getFriends(self.user!)
     ```
     */
    func getFriends (user: PFUser) -> [String]! {
        return user.value(forKey: ParseObjectColumns.Friends.rawValue) as? [String]
    }
    
    /**
     * - Description Get the Interests of a user
     * - Parameter user - The user of which to get the interests from
     * - Returns [String] - The interests of the user
     ```
        DEUserManager.sharedManager.getBio(self.user!)
     ```
     */
    func getInterests (user: PFUser) -> [String]! {
        return user.value(forKey: ParseObjectColumns.Interests.rawValue) as? [String]
    }
    
    /**
     * - Description Get the bio for a user
     * - Parameter user PFUser - the user of which to get the interests from
     * - Returns User bio
     ```
        DEUserManager.sharedManager.getBio(self.user!)
     ```
     */
    func getBio (user: PFUser) -> String! {
        return user.value(forKey: ParseObjectColumns.UserBio.rawValue) as? String
    }
    
    /**
     * - Description Set the bio for the current user
     * - Parameter bio String - The bio that will be set
     ```
        DEUserManager.sharedManager.setBio("The bio for the user")
     ```
     */
    func setBio (bio: String) {
        if PFUser.current() != nil {
            PFUser.current()?.setValue(bio, forKey: ParseObjectColumns.UserBio.rawValue)
            PFUser.current()?.saveInBackground { (success, error) in
                if error != nil {
                    print("Error saving the user in the background - \(error?.localizedDescription)")
                }
            }
        }
    }
}
