//
//  Constants.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

let kInterestsPlistFile = "interests"

enum StringConstants : String {
    case Hijinnks = "Hijinnks"
    case ViewInvitations = "View Invitations"
    case CreateInvitation = "Create Invitation"
}

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

enum Colors {
    case green
    case blue
    case red
    case grey
    case invitationTextGrayColor
    case invitationHeaderViewColor
}

extension Colors {
    var value: UIColor {
        get {
            switch self {
            case .green:
                return UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 0.75)
            case .blue:
                return UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 0.75)
            case .red:
                return UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 0.75)
            case .grey:
                return UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 0.75)
            case .invitationTextGrayColor:
                return UIColor(red: 68/255, green: 68/255, blue: 68/255, alpha: 0.75)
            case .invitationHeaderViewColor:
                return UIColor(red: 48/255, green: 62/255, blue: 146/255, alpha: 0.75)
            }
        }
    }
}

enum HijinnksViewTypes {
    case MapButton
    case LikeEmptyButton
    case LikeFilledButton
    case HomeButton
    case ProfileButton
    case SearchButton
    case LogoView
}

enum Images : String {
    case HouseButton = "houseButton.png"
    case CreateInvitationButton = "plus.png"
}