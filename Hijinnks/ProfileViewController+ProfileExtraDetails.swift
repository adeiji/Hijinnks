//
//  ProfileViewController+ProfileExtraDetails.swift
//  Hijinnks
//
//  Created by adeiji on 5/9/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

extension ProfileViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.profileView.profileDetailsView.cityYouLiveInTextField {
            // Store the user's city information
            self.user.setObject(textField.text!, forKey: ParseObjectColumns.CityYouLiveIn.rawValue)
        }
        else if textField == self.profileView.profileDetailsView.collegeAttendedTextField {
            // Store user's college information
            self.user.setObject(textField.text!, forKey: ParseObjectColumns.CollegeAttended.rawValue)
        }
        else if textField == self.profileView.profileDetailsView.dateOfBirthTextField {
            // Store user's date of birth information
            self.user.setObject(textField.text!, forKey: ParseObjectColumns.DateOfBirth.rawValue)
        }
        else if textField == self.profileView.profileDetailsView.firstNameTextField {
            // Store the user's full name information
            self.user.setObject(textField.text!, forKey: ParseObjectColumns.FirstName.rawValue)
        }
        else if textField == self.profileView.profileDetailsView.lastNameTextField {
            // Store the user's full name information
            self.user.setObject(textField.text!, forKey: ParseObjectColumns.LastName.rawValue)
        }
        
        self.user.saveInBackground { (success, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
        }
    }
    
}
