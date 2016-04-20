//
//  DetailViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 20/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    var itemStore:[(lat: Double, lng: Double)] = []
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        let item = itemStore[indexPath.row]
        
        
        cell.textLabel?.text = "Lat:\(item.lat), Lng:\(item.lng)"
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.count
    }
    
}