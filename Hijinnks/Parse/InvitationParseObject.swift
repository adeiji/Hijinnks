//
//  Invitation.swift
//  Hijinnks
//
//  Created by adeiji on 2/24/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import Parse

class InvitationParseObject : PFObject, PFSubclassing {
    
    class func parseClassName () -> String {
        return ParseCustomObjectsClassNames.Invitation.rawValue
    }
    
    var eventName : String {
        get {
            return self[ParseObjectColumns.EventName.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.EventName.rawValue] = newValue
        }
    }
 
    var location : CLLocation! {
        get {
            return self[ParseObjectColumns.Location.rawValue] as! CLLocation
        }
        set {
            self[ParseObjectColumns.Location.rawValue] = newValue
        }
    }
    
    var details : String {
        get {
            return self[ParseObjectColumns.Details.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.Details.rawValue] = newValue
        }
    }
    
    var message : String {
        get {
            return self[ParseObjectColumns.Message.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.Message.rawValue] = newValue
        }
    }
    
    var startingTime : Date! {
        get {
            return self[ParseObjectColumns.StartingTime.rawValue] as! Date
        }
        set {
            self[ParseObjectColumns.StartingTime.rawValue] = newValue
        }
    }
    
    var duration : String! {
        get {
            return self[ParseObjectColumns.Duration.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.Duration.rawValue] = newValue
        }
    }
    
    var invitees : Array<Any> {
        get {
            return self[ParseObjectColumns.Invitees.rawValue] as! Array<Any>
        }
        set {
            self[ParseObjectColumns.Invitees.rawValue] = newValue
        }
    }
    
    var interests : String! {
        get {
            return self[ParseObjectColumns.Interests.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.Interests.rawValue] = newValue
        }
    }
    
}
