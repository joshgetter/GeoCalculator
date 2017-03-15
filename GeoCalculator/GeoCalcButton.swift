//
//  GeoCalcButton.swift
//  GeoCalculator
//
//  Created by Josh Getter on 2/24/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation
import UIKit
class GeoCalcButton : UIButton{
    override func awakeFromNib() {
        self.tintColor = BACKGROUND_COLOR
        self.backgroundColor = FOREGROUND_COLOR
        self.layer.cornerRadius = 5.0
    }
}
