//
//  ViewController.swift
//  Grouped
//
//  Copyright (c) 2014 Grouped. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var hidingSignin: UIView!
	@IBOutlet weak var welcomeMessage: UILabel!
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
	var defaultUser = NSUserDefaults.standardUserDefaults()

	override func viewDidLoad() {
		hidingSignin.hidden = false
		var uname: AnyObject? = defaultUser.objectForKey("GroupedUserName")
		if uname != nil {
			PFUser.logInWithUsernameInBackground(uname as String, password: defaultUser.objectForKey("GroupedUserPass") as String, block: { (PFUser user, NSError error) -> Void in
				if user != nil {
					//println("Sign In Successful!")
					self.welcomeMessage.text = "Welcome \(uname!)"
					self.performSegueWithIdentifier("GroupFindSegue", sender: self)
				} else {
					//println("Sign In Failed!")
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
				//println("Sign In Successful!")
				self.defaultUser.setObject(self.usernameField.text, forKey: "GroupedUserName")
				self.defaultUser.setObject(self.passwordField.text, forKey: "GroupedUserPass")
				
                self.performSegueWithIdentifier("GroupFindSegue", sender: self)
            }
            else {
				//println("Sign In Failed!")
			}
        
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    @IBAction func signOut(segue:UIStoryboardSegue) {
        //println("SIGNED OUT FUNCTION")
        hidingSignin.hidden = true
        PFUser.logOut()
        NSUserDefaults.standardUserDefaults().removeObjectForKey("GroupedUserName")
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
		if segue.identifier == "SignUpSegue" {
			var suvc:SignUpViewController = segue.destinationViewController as SignUpViewController
			
		}
		else if segue.identifier == "GroupFindSegue" {
			var fc:FindController = segue.destinationViewController as FindController
		}
	}
	
}

