//
//  Colors.swift
//  Hijinnks
//
//  Created by adeiji on 2/23/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
    case green
    case blue
    case red
    case grey
}

extension Colors {
    var value: UIColor {
        get {
            switch self {
            case .green:
                return UIColor(red: 26/255, green: 188/255, blue: 156/255, alpha: 1.0)
            case .blue:
                return UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            case .red:
                return UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
            case .grey:
                return UIColor(red: 127/255, green: 140/255, blue: 141/255, alpha: 1.0)
            }
        }
    }
}
