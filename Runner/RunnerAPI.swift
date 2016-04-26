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

let session: NSURLSession = {
    let config = NSURLSessionConfiguration.defaultSessionConfiguration()
    return NSURLSession(configuration: config)
}()

struct RunnerAPI {
    
    
    private static let baseURLString = "https://eliten.azurewebsites.net"
    
    private static func runnerURL(typeToGet typeToGet: TypeToGet, parameters: [String:String]?) -> NSURL {
        let path = typeToGet.rawValue
        let components = NSURLComponents(string: baseURLString + path)
        
        return components!.URL!
    }
    
    static func getAllActivitiesURL() -> NSURL {
        return runnerURL(typeToGet: .Activity, parameters: nil)
    }
    
    static func getAllActivities() {
        let url = getAllActivitiesURL()
        let request = NSURLRequest(URL: url)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                if let jsonString = NSString(data: jsonData, encoding: NSUTF8StringEncoding) {
                    print(jsonString)
                }
            }
            else if let requestError = error {
                print("Error fetching activities: \(requestError)")
            }
            else {
                print("Unexpected error")
            }
        }
        task.resume()
    }
}
