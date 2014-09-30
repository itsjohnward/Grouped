//
//  CustomCell.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet var Username : UILabel?
    @IBOutlet var Subject : UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func loadItem(username: String, subject: String) {
        self.Username?.text = username
        self.Subject?.text = subject
    }


}
