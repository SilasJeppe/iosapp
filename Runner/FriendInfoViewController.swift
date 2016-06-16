//
//  FriendInfoViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 15/06/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class FriendInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet weak var activityTable: UITableView!
    
    
    var currentFriend = User(id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "UserCell")
        activityTable.delegate = self
        activityTable.dataSource = self
        
        nameLabel.text = currentFriend.firstName + " " + currentFriend.surName
        cityLabel.text = currentFriend.city + ", " + String(currentFriend.zipCode)
        
        activityTable.reloadData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath)
        cell.textLabel?.text = currentFriend.activities[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentFriend.activities.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("FriendActivity", sender: indexPath)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "FriendActivity" {
            let row = (sender as! NSIndexPath).row
            let friendActivityToSegue = currentFriend.activities[row]
            let activityViewController = segue.destinationViewController as! ActivityViewController
            activityViewController.currentActivity = friendActivityToSegue
        }
    }
}
