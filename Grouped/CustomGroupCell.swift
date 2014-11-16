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
	@IBOutlet weak var distanceAmountLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
	
	func loadItem(username: String, subject: String) {
	}
	
	
}
