//
//  FriendsViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 13/06/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    var tableViewUsers = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        RunnerAPI.getAllUsers {
            users in self.tableViewUsers = users
            dispatch_async(dispatch_get_main_queue(), { () -> Void in self.tableView.reloadData()
            })
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("FriendCell", forIndexPath: indexPath)
        let firstName = tableViewUsers[indexPath.row].firstName
        let surName = tableViewUsers[indexPath.row].surName
        cell.textLabel?.text = firstName + " " + surName
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewUsers.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FriendInfo" {
            let selectedIndex = self.tableView.indexPathForCell(sender as! UITableViewCell)
            let friendToSegue = tableViewUsers[(selectedIndex?.row)!]
            let friendInfoViewController = segue.destinationViewController as! FriendInfoViewController
            friendInfoViewController.currentFriend = friendToSegue
        }
    }
}