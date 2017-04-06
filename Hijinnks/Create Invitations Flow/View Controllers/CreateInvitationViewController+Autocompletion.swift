//
//  CreateInvitationViewController+Autocompletion.swift
//  Hijinnks
//
//  Created by adeiji on 2/24/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import GooglePlaces
import Parse

extension CreateInvitationViewController : GMSAutocompleteViewControllerDelegate {
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        locationTextField.text = place.formattedAddress
        self.place = place
        self.location = PFGeoPoint(latitude: place.coordinate.latitude , longitude: place.coordinate.longitude)
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "header.png")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "header.png")!.resizableImage(withCapInsets: UIEdgeInsetsMake(0, 0, 0, 0), resizingMode: .stretch), for: .default)
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
