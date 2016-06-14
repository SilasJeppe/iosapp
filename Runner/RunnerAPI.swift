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

func convertTime(timeSpan: String) -> NSTimeInterval {
    
    let time = (timeSpan as NSString).substringToIndex(8)
    let timeItems = time.componentsSeparatedByString(":")
    
    let hoursInSeconds = Double(timeItems[0])! * 3600.00
    let minutesInSeconds = Double(timeItems[1])! * 60.00
    let seconds = Double(timeItems[2])!
    
    let result = hoursInSeconds + minutesInSeconds + seconds
    
    return result
}



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
    
    static func getAllUsers(completionHandler: (allUsers: [User]) -> () ) {
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
                    user.zipCode = (dictionary["ZipCode"] as! Int)
                    user.phoneNumber = (dictionary["PhoneNumber"] as! Int)
                    user.email = (dictionary["Email"] as! String)
                    
                    let activityArrayFromJSON = (dictionary["ActivityList"] as? NSArray)
                    for activity in activityArrayFromJSON! {
                        let id = (activity["ID"] as? Int)
                        var activityToAdd = Activity(newId: id!)
                        activityToAdd.name = (activity["Name"] as? String)!
                        activityToAdd.description = (activity["Description"] as? String)!
                        activityToAdd.distance = (activity["Distance"] as? Double)!
                        let dateString = (activity["Date"] as? String)
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        activityToAdd.date = dateFormatter.dateFromString(dateString!)!
                        
                        // TODO: Create method to take timespan from database, split it and convert it to NSTimeInterval
                        let timeSpan = (activity["Time"] as? String)!
                        activityToAdd.time = convertTime(timeSpan)
                        
                        activityToAdd.startAddress = (activity["StartAddress"] as? String)!
                        activityToAdd.endAddress = (activity["EndAddress"] as? String)!
                        
                        activityToAdd.route.id = (activity["Route"]!!["ID"] as? Int)!
                        activityToAdd.route.activityID = (activity["Route"]!!["ActivityID"] as? Int)!
                        
                        let pointListFromJSON = (activity["Route"]!!["PointList"] as? NSArray)
                        for point in pointListFromJSON! {
                            let id = (point["ID"] as? Int)!
                            let coordinate = CLLocationCoordinate2D(latitude: (point["Coords"]!!["Y"] as? Double)!, longitude: (point["Coords"]!!["X"] as?Double)!)
                            let routeID = (point["RouteID"] as? Int)!
                            let pointToAdd = Point(id: id, coordinate: coordinate, routeID: routeID)
                            activityToAdd.route.pointList.append(pointToAdd)
                        }
                        user.activities.append(activityToAdd)

                    }
                    allUsers.append(user)
                }
                completionHandler(allUsers: allUsers)
            }
            catch let error {
                print("(json error: \(error))")
            }
        }
        task.resume()
    }
}
