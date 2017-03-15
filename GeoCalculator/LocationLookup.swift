//
//  LocationLookup.swift
//  GeoCalculator
//
//  Created by Josh Getter on 3/15/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation
struct LocationLookup{
    var origLat: Double
    var origLng: Double
    var destLng: Double
    var destLat: Double
    var timestamp: Date
    
    init(origLat: Double, origLng: Double, destLat: Double, destLng:Double, timestamp:Date){
        self.origLat = origLat
        self.origLng = origLng
        self.destLat = destLat
        self.destLng = destLng
        self.timestamp = timestamp
    }
}
