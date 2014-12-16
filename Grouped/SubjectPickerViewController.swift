//
//  SubjectPickerViewController.swift
//  Grouped
//
//  Created by Jonathan Samudio on 12/15/14.
//  Copyright (c) 2014 Jonathan Samudio. All rights reserved.
//

import Foundation


class SubjectPickerViewController: UITableViewController {

    var subjects:[String]!
    var selectedSubject:String? = nil
    var selectedSubIndex:Int? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        subjects = ["Math","Physics", "Science", "Computer Science", "Pyschology", "English", "General Studies"]
        
        subjects.sort{$0.lowercaseString < $1.lowercaseString}
        
        if let subject = selectedSubject {
            selectedSubIndex = find(subjects, subject)!
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SubjectCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = subjects[indexPath.row]
        
        if indexPath.row == selectedSubIndex {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        //Other row is selected - need to deselect it
        if let index = selectedSubIndex {
            let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0))
            cell?.accessoryType = .None
        }
        
        selectedSubIndex = indexPath.row
        selectedSubject = subjects[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            let cell = sender as UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            selectedSubIndex = indexPath?.row
            if let index = selectedSubIndex {
                selectedSubject = subjects[index]
            }
    }

}
