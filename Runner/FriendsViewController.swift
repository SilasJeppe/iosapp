//
//  FriendsViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 13/06/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
}