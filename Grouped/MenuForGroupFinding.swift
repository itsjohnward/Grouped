//
//  MenuForGroupFinding.swift
//  Grouped
//
//  Created by Abus on 12/5/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation

class MenuForGroupFinding : UIViewController {
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	@IBAction func createGroup(sender: AnyObject) {
		var backview = backViewController()
		if backview?.title == "Group Finder" {
			navigationController!.popToViewController(backview!, animated: false)
			backview!.performSegueWithIdentifier("CreateGroupSegue", sender: sender)
		}
	}
	
	func backViewController() -> UIViewController? {
		var naviViews = self.navigationController!.viewControllers
		for var i = naviViews.count - 1; i > 0; --i {
		if (naviViews[i] as NSObject == self) {
			return (naviViews[i - 1] as UIViewController)
			}}
		return nil
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}