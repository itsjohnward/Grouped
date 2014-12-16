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
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var distanceAmountLabel: UILabel!
	@IBOutlet weak var timeLabel: UIView!//Don't use; leave it alone; references to the View itself
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	
    func loadItem(group: Group, homeGeo: PFGeoPoint?){
        
		self.groupName.text = group.name
		subjectLabel.text = group.course
		
		if homeGeo != nil {
			var latDiff = group.location.latitude - homeGeo!.latitude
			var longDiff = group.location.longitude - homeGeo!.longitude
			
			var diff = pow(pow(latDiff, 2)+pow(longDiff, 2), 0.5)
            
            var myLat:Float = Float(homeGeo!.latitude)
            var myLon:Float = Float(homeGeo!.longitude)
            
            var distance:Double = group.calcDistance(myLat, myLon: myLon)
            
			distanceAmountLabel.text = "\(distance) Mi"
            
		} else {
			distanceAmountLabel.hidden = true
		}
	}
    
}
