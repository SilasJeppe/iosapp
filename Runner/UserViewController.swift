//
//  UserViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 24/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

func addDistance(activityList: [Activity]) -> Double {
    var addedDistance = 0.0
    
    for activities in activityList {
        addedDistance += activities.distance
    }
    return addedDistance
}

func addTime(activityList: [Activity]) -> NSTimeInterval {
    var addedTime = 0.0
    
    for activities in activityList {
        addedTime += activities.time
    }
    return addedTime
}

class UserViewController: UIViewController {
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    @IBOutlet var totalDistanceLabel: UILabel!
    @IBOutlet var totalTimeLabel: UILabel!
    @IBOutlet var latestDistanceLabel: UILabel!
    @IBOutlet var latestTimeLabel: UILabel!
    
    
    var currentUser = User(id: 0)
    var myActivities = [Activity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RunnerAPI.getAllActivities {
            activities in self.myActivities = activities
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.latestDistanceLabel.text = String(self.myActivities.last!.distance) + " KM"
                self.latestTimeLabel.text = String(self.myActivities.last!.time) + " seconds"
                
                self.totalDistanceLabel.text = String(addDistance(self.myActivities)) + " KM"
                self.totalTimeLabel.text = String(addTime(self.myActivities)) + " seconds"
                })
        }
        //Place users name, city and zipcode in labels
        nameLabel.text = currentUser.firstName + " " + currentUser.surName
        townLabel.text = currentUser.city + "," + " " + String(currentUser.zipCode)
        }
}