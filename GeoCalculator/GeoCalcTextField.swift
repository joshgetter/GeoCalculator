//
//  GeoCalcTextField.swift
//  GeoCalculator
//
//  Created by Josh Getter on 2/24/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation
import UIKit
class GeoCalcTextField : DecimalMinusTextField{
    override func awakeFromNib() {
        self.textColor = FOREGROUND_COLOR
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1.0
        self.layer.borderColor = FOREGROUND_COLOR.cgColor
        self.layer.cornerRadius = 5.0
        
        guard let placeholderText = self.placeholder else{
            return
        }
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [NSForegroundColorAttributeName : FOREGROUND_COLOR])
    }
}
