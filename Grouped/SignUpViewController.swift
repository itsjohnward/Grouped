//
//  SignUpViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 11/2/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
	
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var nicknameField: UITextField!
	@IBOutlet weak var ageField: UITextField!
	@IBOutlet weak var schoolField: UITextField!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpUser(AnyObject) {
        println("Sign Up User Button Tapped!")
		
        var user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user.email = emailField.text
		
        user["name"] = nicknameField.text
        user["age"] = ageField.text.toInt()!
        user["school"] = schoolField.text
        
        user.signUpInBackgroundWithBlock { (Bool succeeded, NSError error) -> Void in
            if(succeeded){
                println("Sign Up Success!")
				self.performSegueWithIdentifier("GroupFindSegue2", sender: self)
            }
            else {println("Sign Up Failed!")}
        }
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "GroupFindSegue2" {
			var fc:FindController = segue.destinationViewController as FindController
		}
	}
}
