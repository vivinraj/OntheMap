//
//  MapViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 01/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation

import UIKit
import MapKit

class MapViewController : UIViewController, MKMapViewDelegate {
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    @IBOutlet weak var mapView: MKMapView!
    
    var studentDictionary: [[String: AnyObject]]?
    var annotations = [MKPointAnnotation]()
    
    func mapViewLoad() {
        if self.studentDictionary != nil {
            let count = studentDictionary!.count - 1
            for index in 1...count {
                let dictionary = studentDictionary![index]
                if (dictionary["latitude"] != nil) {
                    if (dictionary["longitude"] != nil) {
        
                        let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
                        let long = CLLocationDegrees(dictionary["longitude"] as! Double)
                        // The lat and long are used to create a CLLocationCoordinates2D instance.
        
                        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        var first = dictionary["firstName"] as! String
                        var last = dictionary["lastName"] as! String
                        var mediaURL = dictionary["mediaURL"] as! String
                        if first == "" { first = "Unknown" }
                        if last == "" {last = "Unknown" }
                        if mediaURL == "" {mediaURL = "No link provided"}
                        // Here we create the annotation and set its coordiate, title, and subtitle properties
                        let annotation = MKPointAnnotation()
                        annotation.coordinate = coordinate
                        annotation.title = "\(first) \(last)"
                        annotation.subtitle = mediaURL
                        //print("Annotation: \(annotation)")
                        // Finally we place the annotation in an array of annotations.
                        annotations.append(annotation)
                        //print("Annotations: \(annotations)")
                        // This is the line with the issue. If you comment this out, things will start working
                        //self.mapView.addAnnotations(annotations)
                        //print("Student Dictionar : \(studentDictionary)")
                    }
                }
            }
     //   self.mapView.removeAnnotations(annotations)
        
        self.mapView.addAnnotations(annotations)
        }
    
    else {
    self.studentDictionary = nil
    //print("Student Dictionar in else : \(studentDictionary)")
        }
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentLocation()
        getUserData()
        self.mapViewLoad()
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        print(" Reuse id is done")
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
            print("else in mapView func")
        }
        return pinView
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
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                //print("Student location parsed result: \(parsedResult)")
                self.studentDictionary = parsedResult["results"] as? [[String: AnyObject]]
                //print("Reloading data")
                
                self.mapViewLoad()
                
            }
            catch {
                print(error)
                return
            }
        }
        task.resume()
    }
    
    func getUserData() {
        print("Key ID : \(appDelegate.keyID)")
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/users/\(appDelegate.keyID!)")!)
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
                
                print("Parsed Result in getUserData: \(parsedResult)")
                guard let user = parsedResult["user"] as? NSDictionary else {
                    return
                }
                
                self.appDelegate.fName = user["first_name"] as! String
                self.appDelegate.lName = user["last_name"] as! String
                
                
                
            }
        }
        task.resume()
    }
    

    
    @IBAction func postLocation(sender: AnyObject) {
        //var controller: ViewController
        let controller = (self.storyboard?.instantiateViewControllerWithIdentifier("postLocationViewController"))! as UIViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
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
            
            guard let expirationDictionary = parsedResult["session"] as? NSDictionary else {
                return
            }
            print("Expiration: \(expirationDictionary)")
            
            dispatch_async(dispatch_get_main_queue(), {
            let loginController = (self.storyboard?.instantiateViewControllerWithIdentifier("LoginViewController"))! as UIViewController
            self.presentViewController(loginController, animated: true, completion: nil)
            })
            
        }
        task.resume()
        
    }
    
    @IBAction func refreshButton(sender: AnyObject) {
        getStudentLocation()
    }
}


