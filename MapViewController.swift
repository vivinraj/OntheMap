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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prefersStatusBarHidden()
        
     //   locations = hardCodedLocationsData()
    
    
    }

    @IBAction func yourLocation(sender: AnyObject) {
    }
}
