//
//  ViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 31/07/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var appDelegate: AppDelegate!
    var keyboardOnScreen = false
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewWillAppear(animated: Bool) {
      //  background.UIColor = "blue"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loginPressed() {
        
        let username: String? = Username.text
        
        let password = Password.text
        
        print("Username: \(username)")
        print("Password: \(password)")
        
        
        
     /*   if (username = nil ) {
            print("username is invalid")
            
        }  */
        
        
        let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.HTTPBody = "{\"udacity\": {\"username\": \"username\", \"password\": \"********\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        print("Request: \(request)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { data, response, error in
            if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) /* subset response data! */
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            do {
                let parsedResult = try! NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                print("parsedResult: \(parsedResult)")
                
            }
            catch {
                print("error")
            }
            
           // var controller: ViewController
            nextVCController = self.storyboard!.instantiateInitialViewController("rootNavigationViewController") as! UINavigationController
          self.presentViewController(nextVCController, animated: true, completion: nil)
            
        }
        
        task.resume()
        
    
    }
    
    @IBAction func loginButton(sender: AnyObject) {
    
    loginPressed()
    }
  

}

