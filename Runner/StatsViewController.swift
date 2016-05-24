//
//  StatsViewController.swift
//  Runner
//
//  Created by Kasper Løkke Hansen on 19/05/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    let currentActivity = Activity(newId: 0)
    
    @IBOutlet var displayTimeLabel: UILabel!
    var startTime = NSDate.timeIntervalSinceReferenceDate()
    var timer = NSTimer()
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        var elapsedTime: NSTimeInterval = currentTime - startTime
        
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
    }
}
