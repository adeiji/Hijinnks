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
    
    var rsvpCount : Int! {
        get {
            return self[ParseObjectColumns.RSVPCount.rawValue] as! Int!
        }
        set {
            self[ParseObjectColumns.RSVPCount.rawValue] = newValue
        }
    }
    
    var eventName : String {
        get {
            return self[ParseObjectColumns.EventName.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.EventName.rawValue] = newValue
        }
    }
 
    var location : PFGeoPoint! {
        get {
            return self[ParseObjectColumns.Location.rawValue] as! PFGeoPoint
        }
        set {
            self[ParseObjectColumns.Location.rawValue] = newValue
        }
    }
    
    var address : String {
        get {
            return self[ParseObjectColumns.Address.rawValue] as! String
        }
        set {
            self[ParseObjectColumns.Address.rawValue] = newValue
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
    var dateInvited : Date! {
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
    
    var invitees : Array<PFUser> {
        get {
            return self[ParseObjectColumns.Invitees.rawValue] as! Array<PFUser>
        }
        set {
            self[ParseObjectColumns.Invitees.rawValue] = newValue
        }
    }
    
    var comments : Array<CommentParseObject>! {
        get {
            return self[ParseObjectColumns.Comments.rawValue] as! Array<CommentParseObject>!
        }
        set {
            self[ParseObjectColumns.Comments.rawValue] = newValue
        }
    }
    
    var interests : Array<String>! {
        get {
            return self[ParseObjectColumns.Interests.rawValue] as! Array<String>
        }
        set {
            self[ParseObjectColumns.Interests.rawValue] = newValue
        }
    }
    var fromUser : PFUser {
        get {
            return self[ParseObjectColumns.FromUser.rawValue] as! PFUser
        }
        set {
            self[ParseObjectColumns.FromUser.rawValue] = newValue
        }
    }
    
    var rsvpUsers : Array<String>! {
        get {
            return self[ParseObjectColumns.RsvpUsers.rawValue] as! Array<String>
        }
        set {
            self[ParseObjectColumns.RsvpUsers.rawValue] = newValue
        }
    }
    
    var isPublic : Bool {
        get {
            return self[ParseObjectColumns.IsPublic.rawValue] as! Bool
        }
        set {
            self[ParseObjectColumns.IsPublic.rawValue] = newValue
        }
    }
    
    
    // Gets a NSObject instance of this PFObject
    func getInvitation () -> Invitation {        
        let location = CLLocation(latitude: self.location.latitude, longitude: self.location.longitude)
        let invitation = Invitation(eventName: self.eventName, location: location, address:self.address, message: self.message, startingTime: self.startingTime, duration: self.duration, invitees: self.invitees, interests: self.interests, fromUser: self.fromUser, dateInvited: self.dateInvited, rsvpCount: self.rsvpCount, rsvpUsers: self.rsvpUsers, comments: self.comments, invitationParseObject: self)
        
        return invitation
    }
}
