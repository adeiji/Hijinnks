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
    var address:String!
    var message:String!
    var startingTime:Date
    var duration:String!
    var invitees:Array<PFUser>!
    var interests:Array<String>!
    var fromUser:PFUser
    var dateInvited:Date
    var rsvpCount:Int!
    
    init(eventName: String, location: CLLocation, address: String!, message: String!, startingTime: Date, duration: String!, invitees: Array<PFUser>!, interests: Array<String>!, fromUser: PFUser, dateInvited: Date, rsvpCount: Int!) {
        
        self.eventName = eventName
        self.location = location
        self.address = address
        self.message = message
        self.startingTime = startingTime
        self.duration = duration
        self.invitees = invitees
        self.interests = interests
        self.fromUser = fromUser
        self.dateInvited = dateInvited
        if rsvpCount != nil {
            self.rsvpCount = rsvpCount
        } else {
            self.rsvpCount = 0
        }
        
    }
    
    func getParseObject () -> PFObject {
        let invitationParseObject = InvitationParseObject()
        invitationParseObject.eventName = self.eventName
        invitationParseObject.location = PFGeoPoint(location: self.location)
        invitationParseObject.address = self.address
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
        invitationParseObject.rsvpCount = self.rsvpCount
        
        return invitationParseObject
    }
    
    
}
