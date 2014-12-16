//
//  JoinGroupController.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
//

import Foundation

class JoinGroupController: UIViewController {
	
	@IBOutlet weak var titleLabel: UINavigationItem!
	@IBOutlet weak var hostLabel: UILabel!
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var placeLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	
	@IBOutlet weak var map: MKMapView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		titleLabel.title = group?.name
		subjectLabel.text = group?.course
		hostLabel.text = group?.host
		
		var geocoder = CLGeocoder()
		var lat = group?.location.latitude
		var lon = group?.location.longitude
		var loc = CLLocation(latitude: lat!, longitude: lon!)
		geocoder.reverseGeocodeLocation(loc, completionHandler: { (placemark, error) -> Void in
			self.placeLabel.text = (placemark[0] as CLPlacemark).name
		})
		let formatter = NSDateFormatter()
		formatter.dateFormat = "hh:mm a"
		timeLabel.text = "Started: \(formatter.stringFromDate(group!.time)), Ends: \(formatter.stringFromDate(group!.endTime))"
		descriptionLabel.text = group?.group_description
		
		
		//MAP STUFF
		let location = CLLocationCoordinate2D(
			latitude: (group?.location.latitude)!,
			longitude: (group?.location.longitude)!
		)
		// 2
		let span = MKCoordinateSpanMake(0.05, 0.05)
		let region = MKCoordinateRegion(center: location, span: span)
		map.setRegion(region, animated: true)
		
		//3
		let annotation = MKPointAnnotation()
		annotation.setCoordinate(location)
		annotation.title = group?.name
		annotation.subtitle = group?.course
		map.addAnnotation(annotation)
        
        var nav = self.navigationController?.navigationBar
        
        if group?.course == "Math" { nav?.barTintColor = UIColor(red:224/255, green:72/255,blue:62/255,alpha:1.0)}
        else if group?.course == "Science" { nav?.barTintColor = UIColor(red:34/255, green:192/255,blue:100/255,alpha:1.0) }
        else if group?.course == "Computer Science" { nav?.barTintColor = UIColor(red:19/255, green:82/255,blue:226/255,alpha:1.0) }
        else if group?.course == "General Studies" { nav?.barTintColor = UIColor(red:255/255, green:153/255,blue:51/255,alpha:1.0) }
        else if group?.course == "English" { nav?.barTintColor = UIColor(red:153/255, green:51/255,blue:153/255,alpha:1.0) }
        else if group?.course == "Physics" { nav?.barTintColor = UIColor(red:153/255, green:153/255,blue:102/255,alpha:1.0) }
        else if group?.course == "Psychology" { nav?.barTintColor = UIColor(red:0/255, green:153/255,blue:153/255,alpha:1.0) }
        
        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
		
	}
    
    @IBAction func leave(segue:UIStoryboardSegue) {
        self.navigationController?.popViewControllerAnimated(true)
    }
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "FeedGroupSegue" {
			var fc:FeedController = segue.destinationViewController as FeedController
            
		}
	}
}
