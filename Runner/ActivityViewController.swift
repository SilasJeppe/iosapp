//
//  ActivityViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 16/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var startAddressLabel: UILabel!
    @IBOutlet var endAddressLabel: UILabel!
    
    var currentActivity = Activity(newId: 0)
    
    override func viewDidLoad() {
        nameLabel.text = currentActivity.name
        descriptionLabel.text = currentActivity.description
        startAddressLabel.text = currentActivity.startAddress
        endAddressLabel.text = currentActivity.endAddress
    }
    
    
}