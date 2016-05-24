//
//  ActivityViewController.swift
//  Runner
//
//  Created by Rasmus Juhl on 16/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit
import MapKit

class ActivityViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.mapType = .Standard
            mapView.pitchEnabled = false
            mapView.rotateEnabled = false
            mapView.scrollEnabled = true
            mapView.zoomEnabled = true
        }
    }
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var startAddressLabel: UILabel!
    @IBOutlet var endAddressLabel: UILabel!
    
    var currentActivity = Activity(newId: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = currentActivity.name
        descriptionLabel.text = currentActivity.description
        startAddressLabel.text = currentActivity.startAddress
        endAddressLabel.text = currentActivity.endAddress
        
        updateView()
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "reuse"
        
        var aView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if aView == nil {
            aView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            //Check what this does.
            aView?.canShowCallout = false
        }
        else {
            aView?.annotation = annotation
        }
        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...
        aView!.image = UIImage(named: "ThisFuckingGuy")
        return aView
    }
    
    func updateView() {
        mapView.layoutMargins = UIEdgeInsets(top: 70, left: 70, bottom: 70, right: 70)
        mapView.showAnnotations(currentActivity.route.pointList, animated: true)
    }
    
    
}