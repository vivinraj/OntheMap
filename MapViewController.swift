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
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var studentDictionary: [[String: AnyObject]]?
    var annotations = [MKPointAnnotation]()
    
    override func viewWillAppear(animated: Bool) {
        //getStudentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStudentLocation()
        //let locations = hardCodedLocationData()
        
        // We will create an MKPointAnnotation for each dictionary in "locations". The
        // point annotations will be stored in this array, and then provided to the map view.
        
        
        // The "locations" array is loaded with the sample data below. We are using the dictionaries
        // to create map annotations. This would be more stylish if the dictionaries were being
        // used to create custom structs. Perhaps StudentLocation structs.
        if self.studentDictionary != nil {
       
            for dictionary in studentDictionary! {
            
            // Notice that the float values are being used to create CLLocationDegree values.
            // This is a version of the Double type.
                let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
                let long = CLLocationDegrees(dictionary["longitude"] as! Double)
                print("Lat:\(lat)")
                print("Lon: \(long)")
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                print("Coordinate: \(coordinate)")
            
            let first = dictionary["firstName"] as! String
            let last = dictionary["lastName"] as! String
            let mediaURL = dictionary["mediaURL"] as! String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            self.mapView.addAnnotations(annotations)
            print("Student Dictionar : \(studentDictionary)")
            }
        }
        
        else {
            self.studentDictionary = nil
            print("Student Dictionar in else : \(studentDictionary)")
        }
        
        // When the array is complete, we add the annotations to the map.
       
        
    }
    

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
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
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                print("Student location parsed result: \(parsedResult)")
                self.studentDictionary = parsedResult["results"] as? [[String: AnyObject]]
                print("Reloading data")
                
                
            }
            catch {
                print(error)
                return
            }
            
            
            print("Student Dictionary: \(self.studentDictionary)")
            
        }
        
        task.resume()
    }
    
}

