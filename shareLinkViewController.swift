//
//  shareLinkViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 14/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class shareLinkViewController: UIViewController, MKMapViewDelegate {
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    var location: String?
    
    @IBOutlet weak var urlText: UITextView!
    @IBOutlet weak var postMapView: MKMapView!
    
   // let username = self.appDelegate
    var username: String?
    var key: String?
    var sessionID: String?
    
    
    var locationLongitude: Double? = nil
    var locationLatitude: Double? = nil
    var URL: String? = nil
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    func getLonNLatfromString(location: String) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(location){ (placemark: [CLPlacemark]?, error: NSError?) in
           /* guard(error != nil) else {
                dispatch_async(dispatch_get_main_queue(), {
                let errorAlert = UIAlertController(title: "Could not find location", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                errorAlert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default, handler: nil))
                
            })
            return
            } */
            
            if let placemark = placemark?[0] {
                print("Placemark: \(placemark)")
                self.postMapView.addAnnotation(MKPlacemark(placemark: placemark))
                let locationCoordinate = (placemark.location?.coordinate)! as CLLocationCoordinate2D
                let span = MKCoordinateSpanMake(0.13, 0.13)
                let region = MKCoordinateRegion(center: locationCoordinate, span: span)
                self.postMapView.setRegion(region, animated: true)
                self.locationLatitude = locationCoordinate.latitude
                self.locationLongitude = locationCoordinate.longitude
                
                }
        
        
    }
    }
    

    
    
    
    
    
    
  
    
    
    
    //@IBOutlet weak var urlText: UITextView!
    //@IBOutlet weak var postLocationMapView: MKMapView!
    
    override func viewDidLoad() {
        print("View loaded")
        username = self.appDelegate.userID
        print("Key: \(self.appDelegate.keyID!)")
        key = self.appDelegate.keyID!
        //Key = String(key)
        sessionID = self.appDelegate.sessionID
        getLonNLatfromString(location!)
        URL = urlText.text!
        
        //self.postStudentLocation()
    }
    
  
    
    
    func postStudentLocation() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        print("Request: \(request)")
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print("Location: \(location!)")
        print("Latitude: \(locationLatitude!)")
        print("Longitude: \(locationLongitude!)")
        print("Media Url : \(urlText.text)")
        
        print("URL : \(URL)")
        print("Key: \(key)")
        
        print("Firstname: \(appDelegate.fName!)")
        print("Last Name: \(appDelegate.lName!)")
        
        
        //request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(location!)\", \"mediaURL\": \"https://udacity.com\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = "{\"uniqueKey\": \(key), \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(location!)\", \"mediaURL\": \"\(URL)\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        request.HTTPBody = "{\"uniqueKey\": \(appDelegate.keyID!), \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(location!)\", \"mediaURL\": \"\(URL)\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        
        request.HTTPBody = "{\"uniqueKey\": \"\(key!)\", \"firstName\": \"\(appDelegate.fName!)\", \"lastName\": \"\(appDelegate.lName!)\",\"mapString\": \"\(location!)\", \"mediaURL\": \"\(URL)\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        //request.HTTPBody = "{\"uniqueKey\": \"\(key)\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"\(location!)\", \"mediaURL\": \"\(urlText.text!)\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        //request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Bangalore\", \"mediaURL\": \"www.google.com\",\"locationLatitude\": \(locationLatitude), \"longitude\": \(locationLongitude)}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        print("Request: \(request.HTTPBody)")
        
        //let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
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

        }
        task.resume()
    }
    
    @IBAction func postButton(sender: AnyObject) {
        postStudentLocation()
    }
    
   func postExistingStudentLocation() {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.HTTPMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
    
       request.HTTPBody = "{\"uniqueKey\": \"\(key!)\", \"firstName\": \"\(appDelegate.fName!)\", \"lastName\": \"\(appDelegate.lName!)\",\"mapString\": \"\(location!)\", \"mediaURL\": \"\(URL)\",\"latitude\": \(locationLatitude!), \"longitude\": \(locationLongitude!)}".dataUsingEncoding(NSUTF8StringEncoding)
    
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
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
        }
    task.resume()
    }
    
    @IBAction func cancelButton(sender: AnyObject) {
        let baseViewController = (storyboard?.instantiateViewControllerWithIdentifier("MapViewController"))! as UIViewController
        self.presentViewController(baseViewController, animated: true, completion: nil)
        
        
    }
    
}
