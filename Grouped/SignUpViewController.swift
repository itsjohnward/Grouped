//
//  SignUpViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 11/2/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
	
	var usernameString = ""
	var passwordString = ""
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	@IBOutlet weak var emailField: UITextField!
	@IBOutlet weak var nicknameField: UITextField!
	@IBOutlet weak var ageField: UITextField!
	@IBOutlet weak var schoolField: UITextField!
	
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
		
        user.setObject(nicknameField.text, forKey: "name")
        user.setObject(ageField.text.toInt()! , forKey: "age")
        user.setObject(schoolField.text, forKey: "school")
        
        user.signUpInBackgroundWithBlock { (Bool succeeded, NSError error) -> Void in
            if(succeeded){
                println("Sign Up Success!")
				self.performSegueWithIdentifier("FeedSegue", sender: self)
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
			if(succeeded){
				println("Sign Up Success!")
				self.performSegueWithIdentifier("FeedSegue", sender: self)
			}
			else {println("Sign Up Failed!")}
		}
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
