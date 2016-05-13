//
//  Activity.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation

struct Activity {
    var id: Int
    var userId: Int
    var name: String
    var description: String
    var distance: Double
    var date: NSDate
    var time: NSTimeInterval
    var startAddress: String
    var endAddress: String
    var route: Route
    
    
    //TODO: Write some proper inits so we don't have to var everything. See use of init in RunnerAPI
    init(newId: Int) {
        id = newId
        userId = 0
        name = "Rasmus"
        description = "Kort tur"
        distance = 5.0
        date = NSDate()
        time = 6.0
        startAddress = "Sigrid Undsets Vej 92B"
        endAddress = "Sofiendalsvej 60"
        route = Route(id: 0, activityID: 0, pointList: [Point]())
    }
    
}