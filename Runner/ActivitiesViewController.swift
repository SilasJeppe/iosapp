//
//  ActivitiesViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    @IBAction func showActivities(sender: AnyObject) {
        //TODO: Write error-handling all the way down the chain so this doesn't crash
        //      if API contact or parsing fails
        
        //Pass along completion handler clore to handle data when async json call finishes.
        RunnerAPI.getAllActivities {
            activities in
            print(activities)
            
        }
    }
}