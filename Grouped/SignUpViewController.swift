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
	
	var usernameString = ""
	var passwordString = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		usernameField.text = usernameString
		passwordField.text = passwordString
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
	@IBAction func signUpDefaultUser(sender: AnyObject) {
		println("Sign Up User Button Tapped!")
		
		var user = PFUser()
		user.username = "grouped"
		user.password = "password"
		user.email = "email@example.com"
		
		user.setObject("Jonathan Samudio", forKey: "name")
		user.setObject( 20 , forKey: "age")
		user.setObject("NYU Polytechnic School of Engineering", forKey: "school")
		
		user.signUpInBackgroundWithBlock { (Bool succeeded, NSError error) -> Void in
			if succeeded {
				println("Sign Up Success!")
				self.performSegueWithIdentifier("GroupFindSegue2", sender: self)
			}
			else {
				var alert = UIAlertController(title: "Registering Error", message: "Invalid email (Probably)", preferredStyle: .Alert)
				self.presentViewController(alert, animated: true, completion: nil)}
		}
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "GroupFindSegue2" {
			var fc:FindController = segue.destinationViewController as FindController
			
			fc.user = User(username: usernameField.text, password: passwordField.text,
				email: emailField.text, name: nicknameField.text, age: ageField.text.toInt()!,
				school: schoolField.text)
		}
	}
}
