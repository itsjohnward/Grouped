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
	@IBOutlet weak var placeSwitch: UISegmentedControl!
	@IBOutlet weak var placeLabel: UITextField!
	@IBOutlet weak var descriptionField: UITextView!
	
	var locationManager = CLLocationManager()
	var location:CLLocation?
	var geoLoc:PFGeoPoint?
	var user:User?
	var group:Group?
	var locationAvailable = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		timeStampLabel.text = NSDate().description
		// Do any additional setup after loading the view, typically from a nib.
		locationManager = CLLocationManager()
		
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		
		locationManager.requestWhenInUseAuthorization()
		
		locationManager.startUpdatingLocation()
	}
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		locationAvailable = true
		geoLoc = PFGeoPoint(location: locations[0] as CLLocation)
		var geocoder = CLGeocoder()
		geocoder.reverseGeocodeLocation(locations[0] as CLLocation, completionHandler: { (placemark, error) -> Void in
			self.placeLabel.text = (placemark[0] as CLPlacemark).name
		})
	}
	
	func locationManager(manager:CLLocationManager!, didFailWithError error: NSError!) {
		var alert = UIAlertController(title: "GPS Error", message: "We cannot detect your current location.",
			preferredStyle: .Alert)
		var alertDismiss = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Cancel) {
			(UIAlertAction) -> Void in
				alert.dismissViewControllerAnimated(true, completion: nil)
			}
		alert.addAction(alertDismiss)
		presentViewController(alert, animated: true, completion: nil)
	}
	
	@IBOutlet weak var subjectPicker: UIPickerView!
	@IBAction func editSubject(sender: AnyObject) {
		
	}
	
	@IBAction func createGroup(sender: AnyObject) {
		if !locationAvailable {
			println("GPS isn't ready yet")
			return
		}
		
		var groupOn = PFObject(className:"Group")
		groupOn["name"] = groupNameField.text
		groupOn["hostUser"] = user!.username
		groupOn["time"] = NSDate()
		groupOn["subject"] = "A++ \(subjectPicker.selectedRowInComponent(0))"
		
		groupOn["place"] = geoLoc
		groupOn["description"] = descriptionField.text
		group = Group(name: groupNameField.text, course: "\(subjectPicker.selectedRowInComponent(0))",
			location: geoLoc!, description: descriptionField.text, time: NSDate())
		
		if groupOn.save() {
			self.performSegueWithIdentifier("CreateGroupFeedSegue", sender: self)
		}
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "CreateGroupFeedSegue" {
			var fc:FeedController = segue.destinationViewController as FeedController
			fc.user = user
			fc.navigationItem.title = group?.name
		}
		
	}
}