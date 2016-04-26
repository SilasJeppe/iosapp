//
//  RunnerAPI.swift
//  Runner
//
//  Created by Rasmus Juhl on 21/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation

enum TypeToGet: String {
    case Activity = "/api/Activity"
}

struct RunnerAPI {
    private static let baseURLString = "http://eliten.azurewebsites.net"
    
    private static func runnerURL(typeToGet typeToGet: TypeToGet, parameters: [String:String]?) -> NSURL {
        let path = typeToGet.rawValue
        let components = NSURLComponents(string: baseURLString + path)
        
        return components!.URL!
    }
    
    static func getAllActivitiesURL() -> NSURL {
        return runnerURL(typeToGet: .Activity, parameters: nil)
    }
}