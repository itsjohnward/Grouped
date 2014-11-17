//
//  ViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/23/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var usernameField: UITextField!
	@IBOutlet weak var passwordField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
        //var object = PFObject(className: "TestClass")
        //object.addObject("Banana", forKey: "favoriteFood")
        //object.addObject("Chocolate", forKey: "favoriteIceCream")
        //object.save()
        
    }
    
    //sets up a Parse User
    @IBAction func signIn(AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text, { (PFUser user, NSError error) -> Void in
            if user != nil {
                println("Sign In Successful!")
                self.performSegueWithIdentifier("GroupFindSegue", sender: self)
            }
            else {println("Sign In Failed!")}
        
        })//login
        
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
			suvc.usernameString = usernameField.text
			suvc.passwordString = passwordField.text
		}
		else if segue.identifier == "GroupFindSegue" {
			var fc:FindController = segue.destinationViewController as FindController
			var query = PFQuery(className: "_User")
			query.whereKey("username", equalTo: usernameField.text)
			var object = query.findObjects()[0] as PFObject
			
			fc.user = User(username: object["username"] as String, password: "",
				email: object["email"] as String, name: object["name"] as String, age: object["age"] as Int,
				school: object["school"] as String)
		}
	}
	
}

