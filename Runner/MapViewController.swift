//
//  ViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 18/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    //Instantiate a location manager
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.requestAlwaysAuthorization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func starTracking(sender: AnyObject) {
        
    }


}

