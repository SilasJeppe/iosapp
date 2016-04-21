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
        //This func is called when the app wants to know how to populate our tableView.
        //We declare a cell, decorate that cell with information from an item, and then return the cell
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        let item = itemStore[indexPath.row]
        cell.textLabel?.text = "Lat:\(item.lat), Lng:\(item.lng)"
        return cell
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Func responsible for telling the tableView how many rows is in a section.
        //We are only using one section, so we simply return the size of our itemstore.
        return itemStore.count
    }
    
}