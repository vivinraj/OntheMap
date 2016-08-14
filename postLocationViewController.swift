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
    
    
    
    @IBAction func findOnMapButton(sender: AnyObject) {
        //let controller = (self.storyboard?.instantiateViewControllerWithIdentifier("postLocationViewController"))! as UIViewController
        let controller = shareLinkViewController()
        controller.location = self.locationTextView.text
        self.presentViewController(controller, animated: true, completion: nil)
        
    }
    
}
