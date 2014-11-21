//
//  CustomGroupCell.swift
//  Grouped
//
//  Created by Abus on 11/15/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import GLKit
import Darwin
import CoreLocation

class CustomGroupCell: UITableViewCell {
	
	@IBOutlet weak var groupName: UILabel!
	//@IBOutlet weak var hostName: UILabel!
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var distanceLabel: UILabel!
	@IBOutlet weak var distanceAmountLabel: UILabel!
	@IBOutlet weak var timeLabel: UIView!//Don't use; leave it alone; references to the View itself
	@IBOutlet weak var timeLabel2: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	
	func loadItem(groupName: String, hostName: String, subject: String, time: NSDate, coordinates: PFGeoPoint, homeGeo: PFGeoPoint?) {
		self.groupName.text = groupName
		//self.hostName.text = hostName
		subjectLabel.text = subject
		
		var diffTime = time.timeIntervalSinceNow
		if diffTime < 0 {
			timeLabel2.text = "Now"
		} else {
			timeLabel2.text = "\(diffTime) from now"
		}
		
		if homeGeo != nil {
			var latDiff = coordinates.latitude - homeGeo!.latitude
			var longDiff = coordinates.longitude - homeGeo!.longitude
			
			var diff = pow(pow(latDiff, 2)+pow(longDiff, 2), 0.5)
            
            var myLat:Float = Float(homeGeo!.latitude)
            var myLon:Float = Float(homeGeo!.longitude)
            
            var desLat:Float = Float(coordinates.latitude)
            var desLon:Float = Float(coordinates.longitude)
            
            var distance:Double = calcDistance(myLat, myLon: myLon, desLat: desLat, desLon: desLon)
            
			distanceAmountLabel.text = "\(distance) Mi"
            
		} else {
			distanceLabel.hidden = true
			distanceAmountLabel.hidden = true
		}
	}
    
    //Calculates the distance from two coordinates
    func calcDistance(myLat: Float, myLon: Float, desLat: Float, desLon: Float)->Double{
        
        //My Current Location
        var myCLLat:CLLocationDegrees = CLLocationDegrees(myLat)
        var myCLLon:CLLocationDegrees = CLLocationDegrees(myLon)
        var myLocation:CLLocation = CLLocation(latitude: myCLLat, longitude: myCLLon)
        
        //Desired Location
        var desCLLat:CLLocationDegrees = CLLocationDegrees(desLat)
        var desCLLon:CLLocationDegrees = CLLocationDegrees(desLon)
        var desLocation:CLLocation = CLLocation(latitude: desCLLat, longitude: desCLLon)
        
        //Retrieves Distance between two locations
        var dist:CLLocationDistance = myLocation.distanceFromLocation(desLocation)
        
        //Converts to Miles
        var distInMiles:Double = floor( (dist * 0.00062137) * 10) / 10
        
        //Return Double in Mile Units
        return distInMiles
    }
    
}
