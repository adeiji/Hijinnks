//
//  Constants.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation

let kInterestsPlistFile = "interests"

enum fileType : String {
    case plist = "plist"
}

enum InviteesPresets : String {
    case Everyone = "Everyone"
    case Anyone = "Anyone"
}

enum ParseCustomObjectsClassNames : String {
    case Invitation = "Invitation"
}

enum ParseObjectColumns : String {
    case EventName = "eventName"
    case Location = "location"
    case Details = "details"
    case Message = "message"
    case StartingTime = "startingTime"
    case Duration = "duration"
    case Invitees = "invitees"
    case Interests = "interests"
}
