//
//  request.swift
//  OntheMaps
//
//  Created by vivin raj on 18/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation

import UIKit

import MapKit

class request: NSObject {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    
    
    
    
    func loginOut() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.udacityBaseURL + "/session")!)
        //let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "DELETE"
        var xsrfCookie: NSHTTPCookie? = nil
        let sharedCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                print("Parsed Result : \(parsedResult)")
            }
            catch {
                return
            }
            
        }
        task.resume()
        
    }
    
    func getStudentLocation() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        //print("getStudentLocation: \(request)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            //print("getStudentLocation in task: \(error) \(response)")
            if error != nil { // Handle error...
                //print(" error in get student location: \(error)")
                return
                
            }
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                //print("Student location parsed result: \(parsedResult)")
                let studentDictionary = parsedResult["results"] as? [[String: AnyObject]]
                               
            }
            catch {
                //print(error)
                return
            }
            
            
            //print("Student Dictionary: \(self.studentDictionary)")
            
        }
        
        task.resume()
    }

    func getUserData() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/\(appDelegate.keyID)")!)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil {
                //Display error.localized blablabla
                print(error!.localizedDescription)
                return
            } else {
                guard let data = data else {
                    return
                }
                
                let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5))
                let parsedResult = try! NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments) as! NSDictionary
                guard let user = parsedResult["user"] as? NSDictionary else {
                    return
                }
                
                self.appDelegate.fName = user["first_name"] as! String
                self.appDelegate.lName = user["last_name"] as! String
                
              
                
            }
        }
        task.resume()
    }

    
    
    

}
