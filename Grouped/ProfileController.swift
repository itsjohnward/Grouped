//
//  ProfileController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
	@IBOutlet weak var usernameLabel: UITextField!
	@IBOutlet weak var nicknameLabel: UITextField!
	@IBOutlet weak var emailLabel: UITextField!
	@IBOutlet weak var ageLabel: UITextField!
	@IBOutlet weak var schoolLabel: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		
		//println("Username: \(user!.username)")
		
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
	
	@IBAction func logout(sender: UIButton) {
		PFUser.logOut()
		NSUserDefaults.standardUserDefaults().removeObjectForKey("GroupedUserName")
		navigationController?.popToRootViewControllerAnimated(true)
	}
	
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "saveChanges" {
			var fc:FindController = segue.destinationViewController as FindController
			PFUser.currentUser()["username"] = usernameLabel.text
			PFUser.currentUser()["name"] = nicknameLabel.text
			PFUser.currentUser()["email"] = emailLabel.text
			PFUser.currentUser()["age"] = ageLabel.text.toInt()
			PFUser.currentUser()["school"] = schoolLabel.text
			PFUser.currentUser().save()
		}
    }
	
}