//
//  Group.swift
//  Grouped
//
//  Created by Abus on 11/3/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class Group {
	init(name:String, host:String = "Unknown", course:String, location:PFGeoPoint,
		description:String, time:NSDate = NSDate()) {
		self.name = name
		self.host = host
		self.course = course
        self.location = location
        self.group_description = description
        self.time = time
    }
	
	var name : String
	var host : String
    var course : String
    var location : PFGeoPoint
    var group_description : String
    var time : NSDate
}