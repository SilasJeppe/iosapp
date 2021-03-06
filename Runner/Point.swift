//
//  Point.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation
import MapKit

class Point: NSObject, MKOverlay {
    let id: Int
    let coordinate: CLLocationCoordinate2D
    let routeID: Int
    
    init(id: Int, coordinate: CLLocationCoordinate2D, routeID: Int) {
        self.id = id
        self.coordinate = coordinate
        self.routeID = routeID
    }
    var boundingMapRect: MKMapRect {
        get {
            let upperLeft = MKMapPointForCoordinate(self.coordinate)
            let bounds = MKMapRectMake(upperLeft.x, upperLeft.y, 2000, 2000)
            return bounds
        }
    }    
}
