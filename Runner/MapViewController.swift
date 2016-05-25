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
    //Outlets
    @IBOutlet var trackingButton: UIButton!
    @IBOutlet var mapView: MKMapView! {
        didSet{
            //Assign the viewController as the delegate of the mapView
            mapView.delegate = self
            mapView.pitchEnabled = false
        }
    }
    
    //Array for holding the LatLngs currently being tracked
    var currentPoints:[(lat: Double, lng: Double)] = []
    
    //Instantiate a location manager
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Request permanent auth to use location services
        locationManager.requestAlwaysAuthorization()
        
        //Tell the mapview to display user location. This triggers CoreLocation internally and makes didUpdateUserLocation fire.
        mapView.showsUserLocation = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        //Delegate func called whenever the system has updated the location of user
        var currentLatLng: (lat: Double, lng: Double)
        currentLatLng = (userLocation.coordinate.latitude, userLocation.coordinate.longitude)
        currentPoints.append(currentLatLng)
        print(userLocation.coordinate)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Identify the segue
//        if segue.identifier == "SaveCoords" {
//            //"Grab" the destionation viewController and send over our data.
//            let detailViewController = segue.destinationViewController as! DetailViewController
//            detailViewController.itemStore = currentPoints
//        }
        if segue.identifier == "Stats" {
            
        }
    }
    
    @IBAction func starTracking(sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        mapView.showsUserLocation = false
    }
}

