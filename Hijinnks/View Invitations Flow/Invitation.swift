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

class Invitation  {

    var eventName:String
    var location:CLLocation
    var details:String!
    var message:String!
    var startingTime:Date
    var duration:String!
    var invitees:Array<Any>!
    var interests:Array<Any>!
    
    init(eventName: String, location: CLLocation, details: String!, message: String!, startingTime: Date, duration: String!, invitees: Array<Any>!, interests: Array<Any>!) {
        
        self.eventName = eventName
        self.location = location
        self.details = details
        self.message = message
        self.startingTime = startingTime
        self.duration = duration
        self.invitees = invitees
        self.interests = interests
        
    }
    
    func getParseObject () -> PFObject {
        let invitationParseObject = InvitationParseObject()
        
    }
    
    
}
