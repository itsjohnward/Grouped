//
//  Group.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
//

import Foundation

var group:Group?

class Group {
	init(name:String, host:String = "Unknown", course:String, location:PFGeoPoint,
        description:String, time:NSDate = NSDate(), endTime:NSDate = NSDate(), homeGeo:PFGeoPoint) {
		self.name = name
		self.host = host
		self.course = course
        self.location = location
        self.group_description = description
		self.time = time
		self.endTime = endTime
        self.dist = 0.0
        self.dist = calcDistance(Float(homeGeo.latitude), myLon: Float(homeGeo.longitude))
    }
	
	var name : String
	var host : String
    var course : String
    var location : PFGeoPoint
    var group_description : String
	var time : NSDate
	var endTime : NSDate
    var dist : Double
    
    //Calculates the distance from two coordinates
    func calcDistance(myLat: Float, myLon: Float)->Double{
        
        //My Current Location
        var myCLLat:CLLocationDegrees = CLLocationDegrees(myLat)
        var myCLLon:CLLocationDegrees = CLLocationDegrees(myLon)
        var myLocation:CLLocation = CLLocation(latitude: myCLLat, longitude: myCLLon)
        
        //Desired Location
        var desCLLat:CLLocationDegrees = CLLocationDegrees(location.latitude)
        var desCLLon:CLLocationDegrees = CLLocationDegrees(location.longitude)
        var desLocation:CLLocation = CLLocation(latitude: desCLLat, longitude: desCLLon)
        
        //Retrieves Distance between two locations
        var distance:CLLocationDistance = myLocation.distanceFromLocation(desLocation)
        
        //Converts to Miles
        var distInMiles:Double = floor( (distance * 0.00062137) * 10) / 10
        
        //Return Double in Mile Units
        return distInMiles
    }
    
}