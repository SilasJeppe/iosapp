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
        RunnerAPI.getAllActivities()
    }
}