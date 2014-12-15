//
//  CreateGroupController.swift
//  Grouped
//
//  Created by Abus on 11/16/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class CreateGroupController : UIViewController, CLLocationManagerDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
	
	@IBOutlet weak var groupNameField: UITextField!
	@IBOutlet weak var descriptionField: UITextView!
	@IBOutlet weak var subjectPicker: UIPickerView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var endDatePicker: UIDatePicker!
	@IBOutlet weak var mapView: MKMapView!
	
	var locationManager = CLLocationManager()
	var location:CLLocation?
	var geoLoc:PFGeoPoint?
	var locationAvailable = false
	var listOfSubjects = ["Calculus I & II", "Discrete Math", "Linear Algebra & Ordinary Differential Equations",
		"Data Analysis", "Mechanics", "Bio Molecular Science", "Chemistry", "Data Structures & Algorithms",
		"Computer Architecture & Organizations", "Operating Systems", "Intro to STS", "Pyschology"]
	
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return listOfSubjects.count
	}
	
	func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
		return listOfSubjects[row]
	}
	
	override func viewDidLoad() {
		scrollView.contentSize = CGSizeMake(self.view.frame.width, 1200)
		
		super.viewDidLoad()
		//timeStampLabel.text = NSDate().description
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
			//self.placeLabel.text = (placemark[0] as CLPlacemark).name
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
		println(error)
	}
	
	@IBAction func createGroup(sender: AnyObject) {
		if !locationAvailable {
			println("GPS isn't ready yet")
			return
		}
		
		var groupOn = PFObject(className:"Group")
		groupOn["name"] = groupNameField.text
		groupOn["hostUser"] = PFUser.currentUser().username
		groupOn["time"] = NSDate()
		groupOn["endTime"] = endDatePicker.date
		groupOn["subject"] = listOfSubjects[subjectPicker.selectedRowInComponent(0)]
		
		groupOn["place"] = geoLoc
		groupOn["description"] = descriptionField.text
		group = Group(name: groupNameField.text, course: subjectPicker.selectedRowInComponent(0).description,
            location: geoLoc!, description: descriptionField.text, time: NSDate(), homeGeo: geoLoc!)
		
		var message = PFObject(className:"Message")
		message["user"] = PFUser.currentUser().username
		message["group"] = group?.name
		message["message"] = "Welcome to \(group!.name)!"
		message.save()
		
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
		}
		
	}
}