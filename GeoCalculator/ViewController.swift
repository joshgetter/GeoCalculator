//
//  ViewController.swift
//  GeoCalculator
//
//  Created by Josh Getter on 1/30/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    @IBOutlet weak var p1Long: UITextField!
    @IBOutlet weak var p2Long: UITextField!
    @IBOutlet weak var p1Lat: UITextField!
    @IBOutlet weak var p2Lat: UITextField!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    @IBAction func calcClick(_ sender: Any) {
        guard (p1Long.text?.isEmpty)! == false && (p1Lat.text?.isEmpty) == false && (p2Lat.text?.isEmpty)! == false && (p2Long.text?.isEmpty)! == false else {
            return
        }
        let lat1 = CLLocationDegrees(Double(p1Lat.text!)!)
        let long1 = CLLocationDegrees(Double(p1Long.text!)!)
        let lat2 = CLLocationDegrees(Double(p2Lat.text!)!)
        let long2 = CLLocationDegrees(Double(p2Long.text!)!)
        let loc1 : CLLocation = CLLocation(latitude: lat1, longitude: long1)
        let loc2 = CLLocation(latitude: lat2, longitude: long2)
        let distance: Double = Double((loc1.distance(from: loc2)) / 1000)
        let distanceRounded = round(100 * distance)/100
        distanceLabel.text = "Distance: " + String(distanceRounded) + " kilometers"
        let bearing = loc1.bearingToPoint(point: loc2)
        let bearingRounded = round(bearing * 100)/100
        bearingLabel.text = "Bearing: " + String(bearingRounded) + " degrees"
        
    }
    @IBAction func clearClick(_ sender: Any) {
        p1Long.text = ""
        p2Long.text = ""
        p1Lat.text = ""
        p2Lat.text = ""
        distanceLabel.text = "Distance: "
        bearingLabel.text = "Bearing: "
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

