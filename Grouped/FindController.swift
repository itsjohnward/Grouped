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
    @IBOutlet weak var filterControl: UISegmentedControl!
    
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
        
        cell.loadItem(group, homeGeo: geoLoc?)
        
        if group.course == "Math" { cell.contentView.backgroundColor = UIColor(red:224/255, green:72/255,blue:62/255,alpha:1.0)}
        else if group.course == "Science" { cell.contentView.backgroundColor = UIColor(red:34/255, green:192/255,blue:100/255,alpha:1.0) }
        else if group.course == "Computer Science" { cell.contentView.backgroundColor = UIColor(red:19/255, green:82/255,blue:226/255,alpha:1.0) }
        else if group.course == "General Studies" { cell.contentView.backgroundColor = UIColor(red:255/255, green:153/255,blue:51/255,alpha:1.0) }
        
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
    
    @IBAction func filterChanged(sender: UISegmentedControl) {
        
        switch filterControl.selectedSegmentIndex
            {
        case 0:
            println("Location Sort")
            GroupData.sort{$0.dist < $1.dist}
            tableView.reloadData()
        case 1:
            println("Subject Sort")
            GroupData.sort{($0.course.lowercaseString) < ($1.course.lowercaseString)}
            tableView.reloadData()
        default:
            break; 
        }
    }
    
    func refreshFeed(){
        
        tableData = [PFObject]()
        GroupData = [Group]()
        
        var query = PFQuery(className: "Group")
		query.whereKey("place" , nearGeoPoint:geoLoc, withinMiles:100.0)
		query.whereKey("endTime", greaterThanOrEqualTo: NSDate())
        tableData += query.findObjects() as [PFObject]
        
        for(var i = 0; i < tableData.count; i++){
            
            var name = tableData[i]["name"] as String
            var subject = tableData[i]["subject"] as String
            var location = tableData[i]["place"] as PFGeoPoint
            var desc = tableData[i]["description"] as String
            var host = tableData[i]["hostUser"] as String
			var time = tableData[i]["time"] as NSDate
			var endTime = tableData[i]["endTime"] as NSDate
            var arrGroup = Group(name: name, host: host, course: subject, location: location,
                description: desc, time: time, endTime: endTime, homeGeo: geoLoc!)
            GroupData.append(arrGroup)
        }
        GroupData.sort{$0.dist < $1.dist}
        
    }
	
	func locationManager(manager:CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
		//This function updates the location
		geoLoc = PFGeoPoint(location: locations[0] as CLLocation)
		refreshFeed()
		locationManager.stopUpdatingLocation()
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
    var start = 0;
    override func viewDidAppear(animated: Bool) {
        //Refresh data
        println("VIEW DID APPEAR")
        //refreshFeed()
        tableView.reloadData()
        
        var nav = self.navigationController?.navigationBar
        if(start == 0){start = 1;}
        else {
          nav?.barTintColor = UIColor(red:247/255, green:247/255,blue:247/255,alpha:1.0)
          nav?.tintColor = UIColor(red:0.0, green:122/255,blue:255/255,alpha:1.0)
          nav?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        }
    }
    
    @IBAction func leave(segue:UIStoryboardSegue) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredData = self.GroupData.filter({( group: Group) -> Bool in
        let stringCourse = (group.course.lowercaseString).rangeOfString(searchText.lowercaseString)
        let stringMatch = (group.name.lowercaseString).rangeOfString(searchText.lowercaseString)
        return (stringMatch != nil) || (stringCourse != nil)
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
		if segue.identifier == "ViewGroupSegue" {
			var jgc:JoinGroupController = segue.destinationViewController as JoinGroupController
            
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView{
               var idx = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!.row
                group = filteredData[idx]
            }
            else {
                var idx = table.indexPathForSelectedRow()!.row
                group = GroupData[idx]
            }
		}
    }
}