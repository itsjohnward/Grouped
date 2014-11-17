//
//  CustomGroupCell.swift
//  Grouped
//
//  Created by Abus on 11/15/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class CustomGroupCell: UITableViewCell {
	
	@IBOutlet weak var groupName: UILabel!
	@IBOutlet weak var hostName: UILabel!
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
		self.hostName.text = hostName
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
			distanceAmountLabel.text = "\(diff)"
		} else {
			distanceLabel.hidden = true
			distanceAmountLabel.hidden = true
		}
	}
}
