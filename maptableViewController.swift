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
    
    func getStudentLocation() {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        print("getStudentLocation: \(request)")
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        print("getStudentLocation: \(request)")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        print("getStudentLocation: \(request)")
        let session = NSURLSession.sharedSession()
        print("starting task")
        let task1 = session.dataTaskWithRequest(request)
        print("getStudentLocation task: \(task1)")
        task1.resume()
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
            //return studentLocationDictionary
            //return studentLocationDictionary
            print("STudent Dictonary: \(self.studentDictionary)")
        }
        
        task.resume()
        
    }
    
    
    
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        getStudentLocation()
        return self.studentDictionary!.count
        
    

    }
}



