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
        println("Sign In User Button Tapped!")
        
        PFUser.logInWithUsernameInBackground(usernameField.text, password: passwordField.text, { (PFUser user, NSError error) -> Void in
            if((user) != nil){
                println("Sign In Successful!")
                self.performSegueWithIdentifier("FeedSegue", sender: self)
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
	}
	
}

