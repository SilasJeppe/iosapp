//
//  Route.swift
//  Runner
//
//  Created by Rasmus Juhl on 26/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation

struct Route {
    var id: Int
    var activityID: Int
    var pointList: [Point]
    
    //TODO: Write some proper inits so we don't have to var everything. See use of init in RunnerAPI
}