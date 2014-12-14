//
//  FeedController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 9/30/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation
import UIKit


class FindController:  UITableViewController, UISearchDisplayDelegate, UISearchBarDelegate,
                UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
	
    var tableData = [PFObject]()
    var GroupData = [Group]()
    var filteredData = [Group]()
	
    @IBOutlet weak var searchBar: UISearchBar!
	@IBOutlet var table: UITableView!
    
	var locationManager = CLLocationManager()
	var geoLoc: PFGeoPoint?
	
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredData.count
        } else {
            return self.GroupData.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CustomGroupCell = self.tableView?.dequeueReusableCellWithIdentifier("Cell") as CustomGroupCell
		
        var group : Group
        
        if tableView == self.searchDisplayController!.searchResultsTableView {
            group = filteredData[indexPath.row]
        } else {
            group = GroupData[indexPath.row]
        }
    
        var name = group.name as String
        var subject = group.course as String
        var time = group.time as NSDate
        var loc = group.location as PFGeoPoint
            
        cell.loadItem(name, subject: subject, time: time, coordinates: loc, homeGeo: geoLoc?)
		
        return cell
    }
    
    override func viewDidLoad() {
        self.searchDisplayController?.searchResultsTableView.rowHeight = 80;
        
		locationManager = CLLocationManager()
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
        geoLoc = PFGeoPoint(location: locationManager.location)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.addTarget(self, action: Selector("refreshInvoked"), forControlEvents: UIControlEvents.ValueChanged)
        
        refreshFeed()
		println("VIEW DID LOAD")
		super.viewDidLoad()
	}
    
    func refreshInvoked() {
        refreshFeed()
        tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    func refreshFeed(){
        
        tableData = [PFObject]()
        GroupData = [Group]()
        
        var query = PFQuery(className: "Group")
        query.whereKey("place" , nearGeoPoint:geoLoc, withinMiles:100.0)
        tableData += query.findObjects() as [PFObject]
        
        for(var i = 0; i < tableData.count; i++){
            
            var name = tableData[i]["name"] as String
            var subject = tableData[i]["subject"] as String
            var location = tableData[i]["place"] as PFGeoPoint
            var desc = tableData[i]["description"] as String
            var host = tableData[i]["hostUser"] as String
            var time = tableData[i]["time"] as NSDate
            
            GroupData.append(Group(name: name, host: host, course: subject, location: location, description: desc, time: time))
        }
    }
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		//This function updates the location
		geoLoc = PFGeoPoint(location: locations[0] as CLLocation)
	}
	func locationManager(manager:CLLocationManager!, didFailWithError error: NSError!) {
		var alert = UIAlertController(title: "GPS Error", message: "We cannot detect your current location.",
			preferredStyle: .Alert)
		var alertDismiss = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { (UIAlertAction) -> Void in
			alert.dismissViewControllerAnimated(true, completion: nil)
		}
		alert.addAction(alertDismiss)
		presentViewController(alert, animated: true, completion: nil)
		println(error)
	}
	
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        //Refresh data
        println("VIEW DID APPEAR")
        //refreshFeed()
        tableView.reloadData()
    }
	
	@IBOutlet weak var settingsView: UIView!
	@IBOutlet weak var createGroupButton: UIButton!
	@IBOutlet weak var sortByLabel: UILabel!
	@IBOutlet weak var segmentSortOption: UISegmentedControl!
	
	/*
	@IBAction func logout(sender: AnyObject) {
		navigationController?.popToRootViewControllerAnimated(true)
	}
	*/
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredData = self.GroupData.filter({( group: Group) -> Bool in
        let stringMatch = group.name.rangeOfString(searchText)
        return (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("ViewGroupSegue", sender: tableView)
    }
	
	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
		if segue.identifier == "CreateGroupSegue" {
			var cgc:CreateGroupController = segue.destinationViewController as CreateGroupController
		}
		else if segue.identifier == "ViewGroupSegue" {
			var jgc:JoinGroupController = segue.destinationViewController as JoinGroupController
            
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView{
               var idx = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!.row
                group = Group(name: filteredData[idx].name, host: filteredData[idx].host,
                    course: filteredData[idx].course, location: filteredData[idx].location,
                    description: filteredData[idx].group_description, time: filteredData[idx].time)
            }
            else {
                var idx = table.indexPathForSelectedRow()!.row
                group = Group(name: GroupData[idx].name, host: GroupData[idx].host,
                    course: GroupData[idx].course, location: GroupData[idx].location,
                    description: GroupData[idx].group_description, time: GroupData[idx].time)
            }
		}
		else if segue.identifier == "ProfileController" {
			var pc:ProfileController = segue.destinationViewController as ProfileController
		}
    }
}