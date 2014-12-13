//
//  ViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/23/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var hidingSignin: UIView!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	var defaultUser = NSUserDefaults.standardUserDefaults()

	override func viewDidLoad() {
		hidingSignin.hidden = false
		var uname: AnyObject? = defaultUser.objectForKey("GroupedUserName")
		if uname != nil {
			PFUser.logInWithUsernameInBackground(uname as String, password: defaultUser.objectForKey("GroupedUserPass") as String, block: { (PFUser user, NSError error) -> Void in
				if user != nil {
					println("Sign In Successful!")
					self.performSegueWithIdentifier("GroupFindSegue", sender: self)
				} else {
					println("Sign In Failed!")
					self.hidingSignin.hidden = true
				}
			})
		} else {
			hidingSignin.hidden = true
		}
		
        super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
    }
    
    //sets up a Parse User
    @IBAction func signIn(AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text, { (PFUser user, NSError error) -> Void in
            if user != nil {
				println("Sign In Successful!")
				self.defaultUser.setObject(self.usernameField.text, forKey: "GroupedUserName")
				self.defaultUser.setObject(self.passwordField.text, forKey: "GroupedUserPass")
				
                self.performSegueWithIdentifier("GroupFindSegue", sender: self)
            }
            else {println("Sign In Failed!")}
        
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "SignUpSegue" {
			var suvc:SignUpViewController = segue.destinationViewController as SignUpViewController
			suvc.usernameField.text = usernameField.text
			suvc.passwordField.text = passwordField.text
		}
		else if segue.identifier == "GroupFindSegue" {
			var fc:FindController = segue.destinationViewController as FindController
		}
	}
	
}

