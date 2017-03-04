//
//  HijinnksButton.swift
//  Hijinnks
//
//  Created by adeiji on 3/4/17.
//  Copyright © 2017 adeiji. All rights reserved.
//

import Foundation
import UIKit

class HijinnksButton : UIButton {
    
    var customButtonType:HijinnksButtonTypes
    
    init(customButtonType: HijinnksButtonTypes) {
        self.customButtonType = customButtonType
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {        
        if customButtonType == .MapButton {
            HijinnksStyleKit.drawMapButton(frame: rect)
        }
        else if customButtonType == .LikeButtonEmpty {
            HijinnksStyleKit.drawLikeButton(frame: rect)
        }
        else if customButtonType == .LikeButtonFilled {
            HijinnksStyleKit.drawLikeButtonFilled(frame: rect, resizing: .stretch)
        }
    }
    
}
