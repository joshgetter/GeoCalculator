//
//  SettingsViewController.swift
//  GeoCalculator
//
//  Created by Josh Getter on 2/15/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewControllerDelegate{
    func indicateSelection(bearingSelection: String, distanceSelection: String)
}

class SettingsViewController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    override func viewDidLoad() {
        distanceUnitLabel.isUserInteractionEnabled = true
        bearingUnitLabel.isUserInteractionEnabled = true
        unitPicker.dataSource = self
        unitPicker.delegate = self
        unitPicker.isHidden = true
    }
    let distancePickerData = ["Kilometers", "Miles"]
    let unitPickerData = ["Degrees","Mils"]
    var pickerData = [String]()
    var selectedDistanceUnit : String = "Kilometers"
    var selectedBearingUnit : String = "Degrees"
    var isDistancePicker: Bool = false
    var delegate : SettingsViewControllerDelegate?
    @IBOutlet weak var unitPicker: UIPickerView!
    @IBOutlet weak var bearingUnitLabel: UILabel!
    @IBOutlet weak var distanceUnitLabel: UILabel!
    /*override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let d = self.delegate{
            d.indicateSelection(bearingSelection: selectedBearingUnit, distanceSelection: selectedDistanceUnit)
        }
    }*/
    @IBAction func cancelClick(_ sender: Any) {
        //self.dismiss(animated: true)
        navigationController?.popViewController(animated: true);
    }
    @IBAction func saveClick(_ sender: Any) {
        //self.dismiss(animated: true)
        navigationController?.popViewController(animated: true);
        if let d = self.delegate{
            d.indicateSelection(bearingSelection: selectedBearingUnit, distanceSelection: selectedDistanceUnit)
        }
    }
    @IBAction func tapBearingUnits(_ sender: UITapGestureRecognizer) {
        pickerData = unitPickerData
        isDistancePicker = false
        unitPicker.reloadAllComponents()
        unitPicker.isHidden = false
    }
    @IBAction func tapDistanceUnits(_ sender: UITapGestureRecognizer) {
        pickerData = distancePickerData
        isDistancePicker = true
        unitPicker.reloadAllComponents()
        unitPicker.isHidden = false
    }
    //Hide picker on click outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        unitPicker.isHidden = true
    }
    //Picker view delegate functions
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(isDistancePicker){
            selectedDistanceUnit = pickerData[row]
            distanceUnitLabel.text = selectedDistanceUnit
        }else{
            selectedBearingUnit = pickerData[row]
            bearingUnitLabel.text = selectedBearingUnit
        }
    }
    
}
