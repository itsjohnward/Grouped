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
	
	var user: User?
    @IBOutlet var tableView: UITableView?
    
    var tableData = ["HW1 - Code blackjack","HW2 - GUI blackjack","HW3 - elegante blackjack"]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomCell = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as CustomCell
        cell.loadItem(tableData[indexPath.row], subject: tableData[indexPath.row])
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//Load messages?
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "ProfileSegue" {
			var pc:ProfileController = segue.destinationViewController as ProfileController
			pc.user = user
		} else if segue.identifier == "PostSegue" {
			var npc:NewPostController = segue.destinationViewController as NewPostController
			npc.user = user
		}
	}
}