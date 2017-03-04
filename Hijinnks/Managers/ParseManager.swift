//
//  ParseManager.swift
//  Hijinnks
//
//  Created by adeiji on 2/24/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import Parse

class ParseManager {
    // Save the Parse Object in the background
    class func save (parseObject: PFObject) {
        parseObject.saveInBackground { (success, error) in
            if success {
                NSLog("Parse Object With ID - " + parseObject.objectId! + "Saved Successfully")
            } else {
                NSLog(error.debugDescription)
            }
        }
    }
    
}
