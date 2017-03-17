//
//  ViewController.swift
//  GeoCalculator
//
//  Created by Josh Getter on 1/30/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

//Authors: Josh Getter and Nam Nguyen
import UIKit
import MapKit
class ViewController: UIViewController, SettingsViewControllerDelegate, HistoryTableViewControllerDelegate{

    @IBOutlet weak var p1Long: UITextField!
    @IBOutlet weak var p2Long: UITextField!
    @IBOutlet weak var p1Lat: UITextField!
    @IBOutlet weak var p2Lat: UITextField!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var bearingLabel: UILabel!
    var entries : [LocationLookup] = [
        LocationLookup(origLat: 90.0, origLng: 0.0, destLat: -90.0, destLng: 0.0,
                       timestamp: Date.distantPast),
        LocationLookup(origLat: -90.0, origLng: 0.0, destLat: 90.0, destLng: 0.0,
                       timestamp: Date.distantFuture)]
    
    var selectedBearingUnit:String = "Degrees"
    var selectedDistanceUnit: String = "Kilometers"
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
        var distance: Double = Double((loc1.distance(from: loc2)))
        var distanceRounded : Double = 0
        var bearing = loc1.bearingToPoint(point: loc2)
        var bearingRounded : Double = 0

        if(selectedDistanceUnit == "Kilometers"){
            distance = distance/1000;
            distanceRounded = round(100 * distance)/100
        }else{
            distance = distance/1609.344
            distanceRounded = round(100 * distance)/100
        }
        if(selectedBearingUnit == "Degrees"){
            bearingRounded = round(100 * bearing)/100
        }
        else{
            bearing = bearing * 17.7777
            bearingRounded = round(100 * bearing)/100
        }
        distanceLabel.text = "Distance: " + String(distanceRounded) + " " + selectedDistanceUnit
        bearingLabel.text = "Bearing: " + String(bearingRounded) + " " + selectedBearingUnit
        entries.append(LocationLookup(origLat: lat1, origLng: long1, destLat: lat2, destLng: long2, timestamp: Date()))
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
        self.view.backgroundColor = BACKGROUND_COLOR
    }
    func indicateSelection(bearingSelection: String, distanceSelection: String) {
        selectedDistanceUnit = distanceSelection
        selectedBearingUnit = bearingSelection
        calcClick(self)
    }
    func selectEntry(entry: LocationLookup) {
        p1Lat.text = String(entry.origLat)
        p1Long.text = String(entry.origLng)
        p2Lat.text = String(entry.destLat)
        p2Long.text = String(entry.destLng)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue"{
            if let dest = segue.destination as? SettingsViewController{
                dest.delegate = self
            }
        }
        else if segue.identifier == "historySegue"{
            if let historyDest = segue.destination as? HistoryTableViewController{
                historyDest.delegate = self
                historyDest.entries = self.entries
            }
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

