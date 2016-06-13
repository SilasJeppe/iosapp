//
//  UserViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 24/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {
    
    @IBOutlet var townLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    var currentUser = User(id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = currentUser.firstName + " " + currentUser.surName
        townLabel.text = currentUser.city + "," + " " + String(currentUser.zipCode)
    }
}