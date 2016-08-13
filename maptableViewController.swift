//
//  maptableViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 07/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation
import UIKit

class maptableViewController: UITableViewController {
    
    var studentDictionary: [[String: AnyObject]]?
    
    
    
    override func viewWillAppear(animated: Bool) {
        getStudentLocation()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func getStudentLocation() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        //print("getStudentLocation: \(request)")
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            print("getStudentLocation in task: \(error) \(response)")
            if error != nil { // Handle error...
                print(" error in get student location: \(error)")
                return
                
            }
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                print("Student location parsed result: \(parsedResult)")
                self.studentDictionary = parsedResult["results"] as? [[String: AnyObject]]
                dispatch_async(dispatch_get_main_queue(), { //to avoid
                    self.tableView.reloadData()
                })
                
            }
            catch {
                print(error)
                return
            }
            
            
            //print("Student Dictionary: \(self.studentDictionary)")
            
        }
        
        task.resume()
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.studentDictionary == nil {
            return 0
        }
        else {
            //print("Count: \(studentDictionary?.count)")
            return studentDictionary!.count
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("maptableViewCell")
        let location = studentDictionary![indexPath.row]
        
        var fName = location["firstName"]
        var lName = location["lastName"]
        if  fName == nil {
            fName = "Unknown"
        }
        if lName == nil {
            lName = "Unknown"
        }
        cell?.textLabel!.text = String(fName!) + " " + String(lName!)
        cell?.imageView?.image = UIImage(named: "pin")
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("maptableViewCell")
        let location = studentDictionary![indexPath.row]
        let url = String(location["mediaURL"]!)
        print("URl = \(url)")
        if let URL = NSURL(string: url) {
            UIApplication.sharedApplication().openURL(URL)
        }
    }
}




