//
//  FeedController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import UIKit


class FindController:  UITableViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
	
    var tableData = [PFObject]()
	
	@IBOutlet var table: UITableView!
	var locationManager = CLLocationManager()
	var geoLoc: PFGeoPoint?
	
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomGroupCell = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as CustomGroupCell
		
		if tableData.count > indexPath.row {
			var name = tableData[indexPath.row]["name"] as String
			var subject = tableData[indexPath.row]["subject"] as String
			cell.loadItem(name, subject: subject, time: tableData[indexPath.row]["time"] as NSDate,
				coordinates: tableData[indexPath.row]["place"] as PFGeoPoint, homeGeo: geoLoc?)
		}
		
        return cell
    }
    
    override func viewDidLoad() {
		
		var query = PFQuery(className: "Group")
		//query.whereKey("username", equalTo: usernameField.text)
		tableData += query.findObjects() as [PFObject]
		
		locationManager = CLLocationManager()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		locationManager.requestWhenInUseAuthorization()
		
		locationManager.startUpdatingLocation()
		
		geoLoc = PFGeoPoint(location: locationManager.location)
		
		super.viewDidLoad()
	}
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		//This function updates the location
		geoLoc = PFGeoPoint(location: locations[0] as CLLocation)
	}
	func locationManager(manager:CLLocationManager!, didFailWithError error: NSError!) {
		var alert = UIAlertController(title: "GPS Error", message: "We cannot detect your current location.",
			preferredStyle: .Alert)
		var alertDismiss = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
			alert.dismissViewControllerAnimated(true, completion: nil)
		}
		alert.addAction(alertDismiss)
		presentViewController(alert, animated: true, completion: nil)
	}
	
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBOutlet weak var settingsView: UIView!
	@IBOutlet weak var createGroupButton: UIButton!
	@IBOutlet weak var sortByLabel: UILabel!
	@IBOutlet weak var segmentSortOption: UISegmentedControl!
	
	/*
	@IBAction func logout(sender: AnyObject) {
		navigationController?.popToRootViewControllerAnimated(true)
	}
	*/
	
	@IBAction func sortTable(sender: UISegmentedControl) {
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "CreateGroupSegue" {
			var cgc:CreateGroupController = segue.destinationViewController as CreateGroupController
		}
		else if segue.identifier == "ViewGroupSegue" {
			var jgc:JoinGroupController = segue.destinationViewController as JoinGroupController
			
			var idx = table.indexPathForSelectedRow()!.row
			group = Group(name: tableData[idx]["name"] as String, host: tableData[idx]["hostUser"] as String,
				course: tableData[idx]["subject"] as String, location: tableData[idx]["place"] as PFGeoPoint,
				description: tableData[idx]["description"] as String, time: tableData[idx]["time"] as NSDate)
		}
		else if segue.identifier == "ProfileController" {
			var pc:ProfileController = segue.destinationViewController as ProfileController
		}
    }
}