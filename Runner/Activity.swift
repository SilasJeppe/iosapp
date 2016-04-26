//
//  Activity.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation

struct Activity {
    let id: Int
    let userId: Int
    var name: String
    var description: String
    var distance: Double
    var date: NSDate
    var time: NSTimeInterval
    var startAddress: String
    var endAddress: String
    var route: Route
    
}