//
//  ViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 31/07/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var keyboardOnScreen = false
    
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        self.view.backgroundColor = UIColor.orangeColor()
        //imgViewBackGround setImage:[UIImage imageNamed:imageName]
        
        
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
        
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.udacityBaseURL + "/session")!)
        //let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.HTTPBody = "{\"udacity\": {\"username\": \"username\", \"password\": \"********\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        print("Request: \(request)")
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
        /*   func displayError(error: String){
                print(error)
                performUIUpdatesOnMain {
                    self.setUIEnabled(true)
                }
            } */
            
            guard(error == nil) else {
                print(error)
                return
            }
            guard let data = data else {
                print("No data")
                return
            }
            
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            print("New Data: \(newData)")
            
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            let parsedResult: AnyObject!
            
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                //print("parsedResult: \(parsedResult)")
                
            }
            catch {
                print("error")
                return
            }
            
            print("parsedResult: \(parsedResult)")
            
            print("Parsed result error: \(parsedResult["error"])")
            
            
            //TODO: Case for invalid login credentials
          /*  if (parsedResult["error"]) != nil {
                print("Invalid Credentials")
                return
            } */
            
            guard let account = parsedResult["session"] as? NSDictionary else {
                return
            }
            print("Account: \(account)")
            
           // let accountSessionID =
        
          //  print("Session ID: \(accountSessionID)")
            
            self.appDelegate.sessionID = account["id"] as? String
            
            print("SessionID: \(self.appDelegate.sessionID)")
            
            guard let session = parsedResult["account"] as? NSDictionary else {
                return
            }
            print("Parsed result for key: \(session)")
            self.appDelegate.keyID = session["key"] as? String
            self.appDelegate.userID = username
            
            
            
            dispatch_async(dispatch_get_main_queue(), {
                let nc = self.storyboard!.instantiateViewControllerWithIdentifier("mapTabViewController") as! UITabBarController
                self.presentViewController(nc, animated: true, completion: nil)
                });
            
            
            
        }
 
        task.resume()
    
    }
    
    
    
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
    
    loginPressed()
    }
  

}

