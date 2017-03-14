//
//  DescriptionAndCreditsViewController.swift
//  Hijinnks
//
//  Created by adeiji on 3/4/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

class DescriptionAndCreditsViewController : UIViewController {
    
    var credits:[String]!
    
    override func viewDidLoad() {
        credits = [String]()
        credits.append("Icon made by Madebyoliver from www.flaticon.com")
        credits.append("Icon made by Google from www.flaticon.com")
        credits.append("Icon made by Madebyoliver from www.flaticon.com")
        credits.append("Icon made by Dinosoft from www.flaticon.com")
    }
    
}
