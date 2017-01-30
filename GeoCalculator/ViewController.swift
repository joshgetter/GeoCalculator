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
        let lat1 = CLLocationDegrees(Double(p1Lat.text!)!)
        let long1 = CLLocationDegrees(Double(p1Long.text!)!)
        let lat2 = CLLocationDegrees(Double(p2Lat.text!)!)
        let long2 = CLLocationDegrees(Double(p2Long.text!)!)
        var loc1 : CLLocation = CLLocation(latitude: lat1, longitude: long1)
        var loc2 = CLLocation(latitude: lat2, longitude: long2)
        let distance = loc1.distance(from: loc2)
        distanceLabel.text = "Distance: " + String(distance)
        
    }
    @IBAction func clearClick(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

