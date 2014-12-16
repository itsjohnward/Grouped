//
//  CreateGroupController.swift
//  Grouped
//
//  Created by Abus on 11/16/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class CreateGroupController : UITableViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var groupNameField: UITextField!
	@IBOutlet weak var descriptionField: UITextView!
	@IBOutlet weak var endDatePicker: UIDatePicker!
	@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var subjectLabel: UILabel!
    
	var locationManager = CLLocationManager()
	var location:CLLocation?
	var geoLoc:PFGeoPoint?
	var locationAvailable = false
    var subject = "General Studies"
		
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	override func viewDidLoad() {
		
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var calendar = NSCalendar.currentCalendar(); var comps = NSDateComponents()
		comps.hour = 1
		endDatePicker.date = calendar.dateByAddingComponents(comps, toDate: NSDate(), options: NSCalendarOptions(0))!
		
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
        
        var nav = self.navigationController?.navigationBar
        
        println("GROUP COURSE: \(subject)")
        if subject == "Math" { nav?.barTintColor = UIColor(red:224/255, green:72/255,blue:62/255,alpha:1.0)}
        else if subject == "Science" { nav?.barTintColor = UIColor(red:34/255, green:192/255,blue:100/255,alpha:1.0) }
        else if subject == "Computer Science" { nav?.barTintColor = UIColor(red:19/255, green:82/255,blue:226/255,alpha:1.0) }
        else if subject == "General Studies" { nav?.barTintColor = UIColor(red:255/255, green:153/255,blue:51/255,alpha:1.0) }
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
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
        else if(groupNameField.text != "") {
		
            var groupOn = PFObject(className:"Group")
            groupOn["name"] = groupNameField.text
            groupOn["hostUser"] = PFUser.currentUser().username
            groupOn["time"] = NSDate()
			
			var time = endDatePicker.date.timeIntervalSinceNow % (60 * 60 * 24)
			while time < 0 { time += (60 * 60 * 24) }
            groupOn["endTime"] = NSDate().dateByAddingTimeInterval(time)
        
            groupOn["subject"] = subject
            groupOn["place"] = geoLoc
            groupOn["description"] = descriptionField.text
            
            group = Group(name: groupNameField.text, course: subject,
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
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
    
    @IBAction func selectedGame(segue:UIStoryboardSegue) {
        let subjectPickerViewController = segue.sourceViewController as SubjectPickerViewController
        var selectedSubject:String = subjectPickerViewController.selectedSubject!
        
        subjectLabel.text = selectedSubject
        subject = selectedSubject
        
        self.navigationController?.popViewControllerAnimated(true)
        
        var nav = self.navigationController?.navigationBar
        
        println("GROUP COURSE: \(subject)")
        if subject == "Math" { nav?.barTintColor = UIColor(red:224/255, green:72/255,blue:62/255,alpha:1.0)}
        else if subject == "Science" { nav?.barTintColor = UIColor(red:34/255, green:192/255,blue:100/255,alpha:1.0) }
        else if subject == "Computer Science" { nav?.barTintColor = UIColor(red:19/255, green:82/255,blue:226/255,alpha:1.0) }
        else if subject == "General Studies" { nav?.barTintColor = UIColor(red:255/255, green:153/255,blue:51/255,alpha:1.0) }
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
    }
}