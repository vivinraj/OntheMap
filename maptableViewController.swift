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
    
    var studentDictionary: [String: AnyObject]?
    
    
    
    override func viewWillAppear(animated: Bool) {
       // prefersStatusBarHidden()
        
        //tableView.reloadData()
        
        
        
    }
    
    func getStudentLocation(completionHandler: (studentDictionary: NSDictionary) -> ()) {
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        print("getStudentLocation: \(request)")
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        print("getStudentLocation: \(request)")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        print("getStudentLocation: \(request)")
        let session = NSURLSession.sharedSession()
        print("starting task")
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
            }
            catch {
                print(error)
                return
            }
            
            self.studentDictionary = parsedResult["results"] as? [String: AnyObject]
           // completionHandler(studentDictionary: self.studentDictionary!)
            
            print("STudent Dictonary: \(self.studentDictionary)")
        }
        
        task.resume()
       /* var index: Int
        for index = 0; index < 500000; ++index {
            print("Index: \(index), Task state: \(task.state)")
        } */
        
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        getStudentLocation{
            studentDictionary in
            //studentDictionary.count
            print("Count: \(studentDictionary.count)")
        }
        return studentDictionary!.count
        
      //  getStudentLocation(studentDictionary)
      //  return self.studentDictionary!.count
        
    }
    
  /*  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("maptableViewCell")
        let location = studentDictionary[indexPath.row]
        cell?.textLabel.text = location.firstName + location.lastName
        cell?.imageView?.image =
        
        return cell
        

    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier("maptableViewCell")
        let location = studentDictionary[indexPath.row]
        
    }
    */
    
    
}



