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

enum ActivityResult {
    case Success([Activity])
    case Failure(ErrorType)
}

enum APIError:ErrorType {
    case InvalidJsonData
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
                do {
                    let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(jsonData, options: [])
                    print(jsonObject)
                }
                catch let error {
                    print("Error fetching JSON object: \(error)")
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
    
    static func activitiesFromJSONData(data: NSData) -> ActivityResult {
        do {
            let jsonObject: AnyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            guard let jsonDictionary = jsonObject as? [NSObject:AnyObject], activities = jsonDictionary["activities"] as? [String:AnyObject], activitiesArray = activities["activity"] as? [[String:AnyObject]] else {
                
                //The JSON structure deosn't match our expectations 
                return .Failure(APIError.InvalidJsonData)
            }
            
            var finalActivities = [Activity]()
            return .Success(finalActivities)
        }
        catch let error {
            return .Failure(error)
        }
    }
}
