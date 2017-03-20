//
//  HistoryTableViewController.swift
//  GeoCalculator
//
//  Created by Josh Getter on 3/15/17.
//  Copyright © 2017 Josh Getter. All rights reserved.
//

import UIKit
protocol HistoryTableViewControllerDelegate{
    func selectEntry(entry: LocationLookup)
}
class HistoryTableViewController: UITableViewController{
    var entries : [LocationLookup] = [ LocationLookup(origLat: 90.0, origLng: 0.0, destLat: -90.0, destLng: 0.0, timestamp: Date.distantPast), LocationLookup(origLat: -90.0, origLng: 0.0, destLat: 90.0, destLng: 0.0, timestamp: Date.distantFuture)]
    
    var delegate : HistoryTableViewControllerDelegate?
    
    var tableViewData: [(sectionHeader: String, entries: [LocationLookup])]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func sortIntoSections(entries: [LocationLookup]) {
        
        var tmpEntries : Dictionary<String,[LocationLookup]> = [:]
        var tmpData: [(sectionHeader: String, entries: [LocationLookup])] = []
        
        // partition into sections
        for entry in entries {
            let shortDate = entry.timestamp.short
            if var bucket = tmpEntries[shortDate] {
                bucket.append(entry)
                tmpEntries[shortDate] = bucket
            } else {
                tmpEntries[shortDate] = [entry]
            }
        }
        
        // breakout into our preferred array format
        let keys = tmpEntries.keys
        for key in keys {
            if let val = tmpEntries[key] {
                tmpData.append((sectionHeader: key, entries: val))
            }
        }
        // sort by increasing date.
        tmpData.sort { (v1, v2) -> Bool in
            if v1.sectionHeader < v2.sectionHeader {
                return true
            } else {
                return false
            }
        }
        self.tableViewData = tmpData
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sortIntoSections(entries: self.entries)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in tableView: UITableView) -> Int { // #warning Incomplete implementation, return the number of sections 
        if let data = self.tableViewData { return data.count } else { return 0 } }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FancyCell", for: indexPath) as! HistoryTableViewCell
        //let ll = entries[indexPath.row]
        if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
            cell.origPoint.text = "(\(ll.origLat.roundTo(places:4)),\(ll.origLng.roundTo(places:4)))"
            cell.destPoint.text = "(\(ll.destLat.roundTo(places:4)),\(ll.destLng.roundTo(places: 4)))"
            cell.timestamp.text = ll.timestamp.description
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // #warning Incomplete implementation, return the number of rows 
        if let sectionInfo = self.tableViewData?[section] { return sectionInfo.entries.count } else { return 0 } }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // use the historyDelegate to report back entry selected to the calculator scene
        if let del = self.delegate {
            if let ll = self.tableViewData?[indexPath.section].entries[indexPath.row] {
                del.selectEntry(entry: ll)
            }

        }
        // this pops to the calculator 
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) ->
        String? {
            return self.tableViewData?[section].sectionHeader
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) ->
        CGFloat {
            return 200.0
    }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection
        section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
        header.contentView.backgroundColor = UIColor.green
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view:
        UIView,
                            forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.red
        header.contentView.backgroundColor = UIColor.green
    }
}


