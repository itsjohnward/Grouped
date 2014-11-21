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
	
	var user: User?
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
			var hostName = tableData[indexPath.row]["hostUser"] as String
			var subject = tableData[indexPath.row]["subject"] as String
			cell.loadItem(name, hostName: hostName, subject: subject, time: tableData[indexPath.row]["time"] as NSDate,
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
		
		locationManager.requestAlwaysAuthorization()
		locationManager.requestWhenInUseAuthorization()
		
		locationManager.startUpdatingLocation()
		
		geoLoc = PFGeoPoint(location: locationManager.location)
		
		super.viewDidLoad()
	}
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		//locationManager.stopUpdatingLocation()
	}
	func locationManager(manager:CLLocationManager!, didFailWithError error: NSError!) {
		var alert = UIAlertController(title: "GPS Error", message: "We cannot detect your current location.", preferredStyle: .Alert)
		var alertDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
			alert.dismissViewControllerAnimated(true, completion: nil)
		}
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
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "CreateGroupSegue" {
			var cgc:CreateGroupController = segue.destinationViewController as CreateGroupController
			cgc.user = user
		} else if segue.identifier == "ViewGroupSegue" {
			var jgc:JoinGroupController = segue.destinationViewController as JoinGroupController
			jgc.user = user
			
			var idx = table.indexPathForSelectedRow()!.row
			var loc = tableData[idx]["place"] as PFGeoPoint
			var time = (tableData[idx]["time"] as NSDate).timeIntervalSinceNow
			var timeString = "\(time) seconds from now"
			if time < 0 {
				timeString = "Ongoing"
			}
			jgc.strings.append(tableData[idx]["name"] as String)
			jgc.strings.append(tableData[idx]["hostUser"] as String)
			jgc.strings.append(tableData[idx]["subject"] as String)
			jgc.strings.append("\(loc.latitude), \(loc.longitude)")
			jgc.strings.append(timeString)
			jgc.strings.append(tableData[idx]["description"] as String)
		}
    }
}