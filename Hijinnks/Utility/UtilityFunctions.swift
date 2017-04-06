//
//  UtilityFunctions.swift
//  Hijinnks
//
//  Created by adeiji on 4/3/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import Parse

class UtilityFunctions {
    
    /**
     * - Description Check to see if a user is Current user or not
     * - Parameter user PFUser - The user we're checking to see if is current or not
     * - Returns Bool - Whether or not the user is the current user
     ```
        UtilityFunctions.isCurrent(user: self.user)
     ```
     */
    class func isCurrent (user: PFUser) -> Bool {
        if user.objectId == PFUser.current()?.objectId {
            return true
        }
        
        return false
    }
    
    class func showNavBar () {
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "header.png")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
    }
    
    class func hideNavBar () {
        UINavigationBar.appearance().setBackgroundImage(nil, for: .default)
    }
    
}
