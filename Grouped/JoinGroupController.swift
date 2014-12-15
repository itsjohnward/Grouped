//
//  JoinGroupController.swift
//  Grouped
//
//  Created by Abus on 11/16/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class JoinGroupController: UIViewController {
	
	@IBOutlet weak var titleLabel: UINavigationItem!
	@IBOutlet weak var hostLabel: UITextField!
	@IBOutlet weak var subjectLabel: UITextField!
	@IBOutlet weak var placeLabel: UITextField!
	@IBOutlet weak var timeLabel: UITextField!
	@IBOutlet weak var descriptionLabel: UITextView!
	
    
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
		timeLabel.text = group?.time.description
		descriptionLabel.text = group?.group_description
        
        var nav = self.navigationController?.navigationBar
        //nav?.barStyle = UIBarStyle.Black
        
        if group?.course == "Math" { nav?.barTintColor = UIColor(red:224/255, green:72/255,blue:62/255,alpha:1.0)}
        else if group?.course == "Science" { nav?.barTintColor = UIColor(red:34/255, green:192/255,blue:100/255,alpha:1.0) }
        else if group?.course == "Computing" { nav?.barTintColor = UIColor(red:19/255, green:82/255,blue:226/255,alpha:1.0) }

        nav?.tintColor = UIColor.whiteColor()
        nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
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
