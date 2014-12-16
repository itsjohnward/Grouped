//
//  FeedController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import UIKit


class FeedController:  UIViewController, UITableViewDelegate, UITableViewDataSource{
	
    @IBOutlet var tableView: UITableView?
    
    var tableData = [PFObject]()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomCell = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        cell.loadItem(tableData[indexPath.row]["user"] as String,
			subject: tableData[indexPath.row]["message"] as String)
        
        return cell
    }
    
    override func viewDidLoad() {
		self.navigationItem.title = group?.name
		
		var query = PFQuery(className: "Message")
		query.whereKey("group", equalTo: group?.name)
		tableData += query.findObjects() as [PFObject]
		
        super.viewDidLoad()
    
    }
	
	/*@IBAction func leaveGroup(sender: AnyObject) {
		var naviViews = self.navigationController!.viewControllers
		for var i = naviViews.count - 1; i > 0; --i {
			if (naviViews[i] as UIViewController).title == "" {
				navigationController!.popToViewController(naviViews[i] as UIViewController, animated: true)
			}}
	}*/
	
	func backViewController() -> UIViewController? {
		var naviViews = self.navigationController!.viewControllers
		for var i = naviViews.count - 1; i > 0; --i {
			if (naviViews[i] as NSObject == self) {
				return (naviViews[i - 1] as UIViewController)
			}}
		return nil
	}
	
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
    /*
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "ProfileSegue" {
			var pc:ProfileController = segue.destinationViewController as ProfileController
		} else if segue.identifier == "PostSegue" {
			var npc:NewPostController = segue.destinationViewController as NewPostController
		}
	}*/
}