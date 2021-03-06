//
//  StatsViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 19/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit
import CoreLocation

class StatsViewController: UIViewController, CLLocationManagerDelegate {
    var currentActivity = Activity(newId: 0)
    var locationManager = CLLocationManager()
    
    @IBOutlet var displayTimeLabel: UILabel!
    var startTime = NSDate.timeIntervalSinceReferenceDate()
    var timer = NSTimer()
    
    
    func updateTime() {
        //TODO: This is complicated. Reduce complexity by only counting seconds?
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        //Store elapsed time in activity every time it updates
        currentActivity.time = elapsedTime
        
        let minutes = UInt8(elapsedTime / 60.0)
        
        elapsedTime -= (NSTimeInterval(minutes) * 60)
        
        let seconds = UInt8(elapsedTime)
        
        elapsedTime -= NSTimeInterval(seconds)
        
        let fraction = UInt8(elapsedTime * 100)
        
        let strMinutes = String(format: "%02d", minutes)
        let strSeconds = String(format: "%02d", seconds)
        let strFraction = String(format: "%02d", fraction)
        
        displayTimeLabel.text = "\(strMinutes):\(strSeconds):\(strFraction)"
    }
    
    override func viewDidLoad() {
        timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(StatsViewController.updateTime), userInfo: nil, repeats: true)
        
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        let newPoint = Point(id: 0, coordinate: CLLocationCoordinate2D(latitude: (locations.last?.coordinate.latitude)!, longitude: (locations.last?.coordinate.longitude)!), routeID: currentActivity.route.id)
        currentActivity.route.pointList.append(newPoint)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Result" {
            timer.invalidate()
            
            var distanceSum: Double = 0
            for index in 0...(currentActivity.route.pointList.count - 2) {
                let nextIndex = index + 1
                let coordinate1: CLLocationCoordinate2D = currentActivity.route.pointList[index].coordinate
                let coordinate2: CLLocationCoordinate2D = currentActivity.route.pointList[nextIndex].coordinate
                let location1: CLLocation = CLLocation(latitude: coordinate1.latitude, longitude: coordinate1.longitude)
                let location2: CLLocation = CLLocation(latitude: coordinate2.latitude, longitude: coordinate2.longitude)
                
                let thisDistance: CLLocationDistance = location1.distanceFromLocation(location2)
                
                distanceSum += thisDistance
            }
            currentActivity.distance = distanceSum
            
            let destinationViewController = segue.destinationViewController as! ResultViewController
            destinationViewController.resultActivity = currentActivity
        }
    }
}
