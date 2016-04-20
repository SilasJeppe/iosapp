//
//  ViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 18/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var trackingButton: UIButton!
    @IBOutlet var mapView: MKMapView!
    
    //Array for holding the LatLngs currently being tracked
    var currentPoints:[(lat: Double, lng: Double)] = []
    
    //Instantiate a location manager
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        locationManager.requestAlwaysAuthorization()
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        var currentLatLng: (lat: Double, lng: Double)
        currentLatLng = (userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        currentPoints.append(currentLatLng)
        print(currentPoints)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Identify the segue
        if segue.identifier == "SaveCoords" {
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.itemStore = currentPoints
        }
    }
    
    @IBAction func starTracking(sender: AnyObject) {
        locationManager.startUpdatingLocation()
        
    }

}

