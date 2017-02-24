//
//  CustomHijinnksView.swift
//  Hijinnks
//
//  Created by adeiji on 2/19/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

public class CustomHijinnksView : UIView {
    
    let hijinnksTextLogo = 1
    let orViewTag = 2
    
    override public func draw(_ rect: CGRect) {
    
        if self.tag == hijinnksTextLogo {
            HijinnksStyleKit.drawTextLogo()
        }
        else if self.tag == orViewTag {
            HijinnksStyleKit.drawOrView(frame: rect)
        }
    }
}

