//
//  Invitation.swift
//  Hijinnks
//
//  Created by adeiji on 2/24/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import CoreLocation
import Parse

class Invitation : NSObject {

    var eventName:String
    var location:CLLocation
    var details:String!
    var message:String!
    var startingTime:Date
    var duration:String!
    var invitees:Array<PFUser>!
    var interests:Array<String>!
    var fromUser:PFUser
    var dateInvited:Date
    
    init(eventName: String, location: CLLocation, details: String!, message: String!, startingTime: Date, duration: String!, invitees: Array<PFUser>!, interests: Array<String>!, fromUser: PFUser, dateInvited: Date) {
        
        self.eventName = eventName
        self.location = location
        self.details = details
        self.message = message
        self.startingTime = startingTime
        self.duration = duration
        self.invitees = invitees
        self.interests = interests
        self.fromUser = fromUser
        self.dateInvited = dateInvited
        
    }
    
    func getParseObject () -> PFObject {
        let invitationParseObject = InvitationParseObject()
        invitationParseObject.eventName = self.eventName
        invitationParseObject.location = PFGeoPoint(location: self.location)
        invitationParseObject.details = self.details
        invitationParseObject.message = self.message
        invitationParseObject.startingTime = self.startingTime
        invitationParseObject.dateInvited = self.dateInvited
        invitationParseObject.duration = self.duration
        
        if self.invitees == nil {
            invitationParseObject.invitees = [PFUser]()
        }
        else {
            invitationParseObject.invitees = self.invitees
        }
        
        invitationParseObject.interests = self.interests
        invitationParseObject.fromUser = self.fromUser
        
        return invitationParseObject
    }
    
    
}
