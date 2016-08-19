//
//  postLocationViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 14/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation
import UIKit

class postLocationViewController: UIViewController {
    
    @IBOutlet weak var locationTextView: UITextView!
    
    override func viewDidLoad() {
        //prefersStatusBarHidden().true
        locationTextView.backgroundColor = UIColor.blueColor()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //locationTextView.backgroundColor = UIColor.blueColor()
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        let baseViewController = (storyboard?.instantiateViewControllerWithIdentifier("MapViewController"))! as UIViewController
        self.presentViewController(baseViewController, animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func findOnMapButton(sender: AnyObject) {
        let controller = (self.storyboard?.instantiateViewControllerWithIdentifier("shareLinkViewController"))! as! shareLinkViewController
        //let controller= shareLinkViewController()
        controller.location = self.locationTextView.text
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
}
