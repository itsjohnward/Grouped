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
	
	var user: User?
    @IBOutlet weak var logOff: UIButton!
	@IBOutlet weak var usernameLabel: UITextField!
	@IBOutlet weak var nicknameLabel: UITextField!
	@IBOutlet weak var emailLabel: UITextField!
	@IBOutlet weak var ageLabel: UITextField!
	@IBOutlet weak var schoolLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
		if user == nil {
			self.performSegueWithIdentifier("LogoutSegue", sender: self)
			return
		}
		usernameLabel.text = user!.username
		nicknameLabel.text = user!.name
		emailLabel.text = user!.email
		ageLabel.text = "\(user!.age)"
		schoolLabel.text = user!.school
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func logOff(AnyObject) {
        //TODO 
        //Code to complete logOff of Account
		self.performSegueWithIdentifier("LogoutSegue", sender: self)
        //self.dismissViewControllerAnimated(true, completion: {});
    }
	
	@IBAction func leaveGroup(sender: AnyObject) {
		self.performSegueWithIdentifier("LeaveGroupSegue", sender: self)
	}
	
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "LeaveGroupSegue" {
			var fc:FindController = segue.destinationViewController as FindController
			fc.user = user
		}
    }
}

