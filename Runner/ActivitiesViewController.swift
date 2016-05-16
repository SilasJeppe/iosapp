//
//  ActivitiesViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class ActivitiesViewController: UITableViewController {
    
    var tableViewActivities = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        //This is called with a completion handler closure to handle the JSON calls being async.
        RunnerAPI.getAllActivities {
            activities in
            self.tableViewActivities = activities
            self.tableView.reloadData()
        }
    }
    
    
    //These are regeuired for us to be a UITableViewController.
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = tableViewActivities[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewActivities.count
    }
}