//
//  CustomCell.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
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
