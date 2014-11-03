//
//  Group.swift
//  Grouped
//
//  Created by Abus on 11/3/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class Group : PFObject {
    init(course:String, location:PFGeoPoint, description:String, time:NSDate = NSDate()) {
        self.course = course
        self.location = location
        self.group_description = description
        self.time = time
        
        self.users = [String]()
        super.init()
    }
    
    var course : String
    var users : [String]
    var location : PFGeoPoint
    var group_description : String
    var time : NSDate
}