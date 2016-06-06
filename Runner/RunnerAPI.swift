//
//  RunnerAPI.swift
//  Runner
//
//  Created by Rasmus Juhl on 21/04/16.
//  Copyright © 2016 rjuhl.dk. All rights reserved.
//

import Foundation
import MapKit

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

class RunnerAPI: NSObject, NSURLConnectionDelegate {
    
    static func getAllActivities(completionHandler: (allActivities: [Activity]) -> ()) {
        var allActivities = [Activity]()
        let url = NSURL(string: "https://eliten.azurewebsites.net/api/Activity")
        let request = NSURLRequest(URL: url!)
        let task = session.dataTaskWithRequest(request) {
            (data, response,error) -> Void in
            
            do {
                //Get a dictionary to work with from JSON
                let result = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [[String: AnyObject]]
                for dictionary in result {
                    //TODO: Fix these forced unwrappings. If let properties from dict?
                    //TODO: Consider using SwiftyJSON?
                    var activity = Activity(newId: (dictionary["ID"] as? Int)!)
                    activity.userId = (dictionary["UserID"] as? Int)!
                    activity.name = (dictionary["Name"] as? String)!
                    activity.description = (dictionary["Description"] as? String)!
                    activity.distance = (dictionary["Distance"] as? Double)!
                    //This needs to read a string from the JSON and convert to NSDate. Just using current date for now
                    activity.date = NSDate()
                    //Same issue as abovebrew
                    activity.time = 0.0
                    activity.startAddress = (dictionary["StartAddress"] as? String)!
                    activity.endAddress = (dictionary["EndAddress"] as? String)!
                    //Notice the subscripting for accessing nested values
                    activity.route.id = (dictionary["Route"]!["ID"] as? Int)!
                    activity.route.activityID = (dictionary["Route"]!["ActivityID"] as? Int)!
                    let pointListFromJSON = (dictionary["Route"]!["PointList"] as? NSArray)
                    for point in pointListFromJSON! {
                        let id = (point["ID"] as? Int)!
                        let coordinate = CLLocationCoordinate2D(latitude: (point["Coords"]!!["Y"] as? Double)!, longitude: (point["Coords"]!!["X"] as?Double)!)
                        let routeID = (point["RouteID"] as? Int)!
                        let pointToAdd = Point(id: id, coordinate: coordinate, routeID: routeID)
                        activity.route.pointList.append(pointToAdd)
                    }
                    allActivities.append(activity)
                }
                completionHandler(allActivities: allActivities)
            }
            catch let error {
                print("(json error: \(error))")
            }
        }
        task.resume()
    }
    
    static func getAllUsers() {
        var allUsers = [User]()
        let url = NSURL(string: "https://eliten.azurewebsites.net/api/User")
        let request = NSURLRequest(URL: url!)
        let task = session.dataTaskWithRequest(request) {
            (data, response, error) -> Void in
            
            do {
                let result = try
                    NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [[String: AnyObject]]
                for dictionary in result {
                    var user = User(id: (dictionary["ID"] as! Int))
                    user.firstName = (dictionary["Firstname"] as! String)
                    user.surName = (dictionary["Surname"] as! String)
                    user.address = (dictionary["Address"] as! String)
                    user.city = (dictionary["City"] as! String)
                    user.zipCode = (dictionary["Zipcode"] as! String)
                    user.phoneNumber = (dictionary["Phonenumber"] as! String)
                    user.email = (dictionary["Email"] as! String)
                    user.activities = (dictionary["ActivityList"] as! Array)
                    allUsers.append(user)
                }
            }
            catch let error {
                print("(json error: \(error))")
            }
        }
        task.resume()
    }
}
