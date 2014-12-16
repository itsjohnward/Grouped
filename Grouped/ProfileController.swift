//
//  ProfileController.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UITableViewController {
	@IBOutlet weak var usernameLabel: UITextField!
	@IBOutlet weak var nicknameLabel: UITextField!
	@IBOutlet weak var emailLabel: UITextField!
	@IBOutlet weak var ageLabel: UITextField!
	@IBOutlet weak var schoolLabel: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()

		self.navigationItem.title = "Profile"
		var age = PFUser.currentUser()["age"] as Int
		
		usernameLabel.text = PFUser.currentUser()["username"] as String
		nicknameLabel.text = PFUser.currentUser()["name"] as String
		emailLabel.text = PFUser.currentUser()["email"] as String
		ageLabel.text = "\(age)"
		schoolLabel.text = PFUser.currentUser()["school"] as String
		
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func saveChanges(sender: UIButton) {
        
        PFUser.currentUser()["username"] = usernameLabel.text
        PFUser.currentUser()["name"] = nicknameLabel.text
        PFUser.currentUser()["email"] = emailLabel.text
        PFUser.currentUser()["age"] = ageLabel.text.toInt()
        PFUser.currentUser()["school"] = schoolLabel.text
        PFUser.currentUser().save()
        
        self.navigationController?.popViewControllerAnimated(true)
	}
	
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "saveChanges" {
			var fc:FindController = segue.destinationViewController as FindController
			
		}
    }
    
    

	
}