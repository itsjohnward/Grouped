//
//  CreateGroupController.swift
//  Grouped
//
//  Created by Abus on 11/16/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class CreateGroupController : UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var groupNameField: UITextField!
	@IBOutlet weak var timeStampSwitch: UISegmentedControl!
	@IBOutlet weak var timeStampLabel: UITextField!
	@IBOutlet weak var subjectPicker: UIPickerView!
	@IBOutlet weak var placeSwitch: UISegmentedControl!
	@IBOutlet weak var placeLabel: UITextField!
	@IBOutlet weak var descriptionField: UITextView!
	
	var locationManager = CLLocationManager()
	var location:CLLocation?
	var geoLoc:PFGeoPoint?
	var user:User?
	var group:Group?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		timeStampLabel.text = NSDate().description
		// Do any additional setup after loading the view, typically from a nib.
		locationManager = CLLocationManager()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		locationManager.requestAlwaysAuthorization()
		locationManager.requestWhenInUseAuthorization()
		
		locationManager.startUpdatingLocation()
		
		geoLoc = PFGeoPoint(location: locationManager.location)
		if geoLoc != nil {
			placeLabel.text = "\(geoLoc!.latitude), \(geoLoc!.longitude)"
		}
	}
	
	@IBAction func updateLocation(sender: UISegmentedControl) {
	}
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		//locationManager.stopUpdatingLocation()
	}
	func locationManager(manager:CLLocationManager!, didFailWithError error: NSError!) {
		var alert = UIAlertController(title: "GPS Error", message: "We cannot detect your current location.", preferredStyle: .Alert)
		var alertDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
			alert.dismissViewControllerAnimated(true, completion: nil)
		}
		alert.addAction(alertDismiss)
		presentViewController(alert, animated: true, completion: nil)
	}
	
	@IBAction func createGroup(sender: AnyObject) {
		var group = PFObject(className:"Group")
		group["name"] = groupNameField.text
		group["hostUser"] = user!.username
		group["time"] = NSDate()
		group["subject"] = subjectPicker.selectedRowInComponent(0)
		
		group["place"] = geoLoc
		group["description"] = descriptionField.text
		if group.save() {
			self.performSegueWithIdentifier("CreateGroupFeedSegue", sender: self)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "CreateGroupFeedSegue" {
			var cgc:CreateGroupController = segue.destinationViewController as CreateGroupController
			cgc.user = user
		}
		
	}
}