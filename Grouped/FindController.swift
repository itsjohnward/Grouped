//
//  FeedController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import UIKit


class FindController:  UITableViewController, UITableViewDelegate, UITableViewDataSource{
	
    let tableData = ["One","Two","Three"]
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomGroupCell = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as CustomGroupCell
        cell.loadItem(tableData[indexPath.row], subject: tableData[indexPath.row])
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO 
        //Load Nearby study sessions
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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