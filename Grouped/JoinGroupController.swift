//
//  JoinGroupController.swift
//  Grouped
//
//  Created by Abus on 11/16/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class JoinGroupController: UIViewController {
	
	@IBOutlet weak var titleLabel: UINavigationItem!
	@IBOutlet weak var hostLabel: UITextField!
	@IBOutlet weak var subjectLabel: UITextField!
	@IBOutlet weak var placeLabel: UITextField!
	@IBOutlet weak var timeLabel: UITextField!
	@IBOutlet weak var descriptionLabel: UITextView!
	
	var user: User?
	var strings = [String]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		titleLabel.title = strings[0]
		hostLabel.text = strings[1]
		subjectLabel.text = strings[2]
		placeLabel.text = strings[3]
		timeLabel.text = strings[4]
		descriptionLabel.text = strings[5]
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "FeedGroupSegue" {
			var fc:FeedController = segue.destinationViewController as FeedController
			fc.user = user
		}
	}
}
