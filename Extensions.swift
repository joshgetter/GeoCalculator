//
//  Extensions.swift
//  GeoCalculator
//
//  Created by Josh Getter on 3/17/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value func roundTo(places:Int) -> Double {
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor }
}

extension Date{
    struct Formatter {
        static let short: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            return formatter
        }()
    }
    var short: String {
        return Formatter.short.string(from: self)
    }
}
