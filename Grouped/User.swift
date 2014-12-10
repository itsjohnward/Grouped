//
//  User.swift
//  Grouped
//
//  Created by Abus on 11/3/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class User : PFUser {
    init(username:String, password:String, email:String, name:String = "", age:Int = 0, school:String = "") {
        self.name = name
        self.age = age
        self.school = school
        
        super.init()
        self.username = username
        self.password = password
        self.email = email
    }

    
    var name:String
    var age:Int
    var school:String
}