//
//  ViewController.swift
//  OntheMaps
//
//  Created by vivin raj on 31/07/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    
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
        Username.delegate = self
        Password.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    /*func setUIEnabled() {
        print("UI elements needed")
    }*/
    /*func displayError(error: String){
        print(error)
        performUIUpdatesOnMain(
            //print("UI elements need to be enabled")
            self.setUIEnabled(true)
        )
    }*/
    
    func loginPressed() {
        let username: String? = Username.text
        let password = Password.text
        print("Username: \(username!)")
        print("Password: \(password!)")
    
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.udacityBaseURL + "/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            /*guard(error == nil) else {
                print("Inside error: \(error)")
                return
            }
            guard let data = data else {
                print("No data")
                return
            }*/
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) // subset response data!
            print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            /*let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                //print("parsedResult: \(parsedResult)")
            }
            catch {
                print("error")
                return
            }
            //print("parsedResult: \(parsedResult)")
            //print("Parsed result error: \(parsedResult["error"])")
            
            guard let account = parsedResult["session"] as? NSDictionary else {
                return
            }
            //print("Account: \(account)")
            self.appDelegate.sessionID = account["id"] as? String
            //print("SessionID: \(self.appDelegate.sessionID)")
            guard let session = parsedResult["account"] as? NSDictionary else {
                return
            }
            //print("Parsed result for key: \(session)")
            self.appDelegate.keyID = session["key"] as? String //Not sure if this is the correct key id
            self.appDelegate.userID = username
            
            self.getUserData()
            
            dispatch_async(dispatch_get_main_queue(), {
                let nc = self.storyboard!.instantiateViewControllerWithIdentifier("mapTabViewController") as! UITabBarController
                self.presentViewController(nc, animated: true, completion: nil)
            });*/
        }
        
        
        task.resume()

 
 
        /*let request = NSMutableURLRequest(URL: NSURL(string: "https://www.udacity.com/api/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"vimalrajmohan@gmail.com\", \"password\": \"C0ldhoraws\"}}".dataUsingEncoding(NSUTF8StringEncoding)*/
        //let session = NSURLSession.sharedSession()
        //let task = session.dataTaskWithRequest(request) { data, response, error in
          /*  if error != nil { // Handle error…
                return
            }
            let newData = data!.subdataWithRange(NSMakeRange(5, data!.length - 5)) // subset response data! /
                print(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
           
        }
        task.resume()*/
        
        /*let request = NSMutableURLRequest(URL: NSURL(string: Constants.udacityBaseURL + "/session")!)
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(username!)\", \"password\": \"\(password!)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request) { (data, response, error) in
            
            //print("At beginning of task: error: \(error), response: \(response)")
            guard(error == nil) else {
                print("Inside error: \(error)")
                return
            }
            
            let statusCode = (response as? NSHTTPURLResponse)!.statusCode
            //This statuscode is always 200
            
            /*guard(statusCode == nil) else {
                //displayError("Could not get statusCode.")
                return
            }*/
            print("Inside error2 status code: \(statusCode)")
            /*if !(statusCode >= 200 && statusCode <= 299){
                    //displayError("Bad statusCode.")
                var message = ""
                if (statusCode >= 100 && statusCode <= 199) {
                    message = "The processing of the inquiry is still ongoing"
                }
                
                if (statusCode >= 300 && statusCode <= 399) {
                    message = "You have been redirected. Try to login again."
                }
                
                if (statusCode >= 400 && statusCode <= 499) {
                    message = "Bad credentials. Try again."
                    print("Message : \(message)")
                }
                    
                let controller = UIAlertController()
                controller.title = "ERROR"
                controller.message = message
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {action in self.dismissViewControllerAnimated(true, completion: nil) })
                controller.addAction(okAction)
                self.presentViewController(controller, animated: true, completion: nil)
                return

            } */
            
            guard let data = data else {
                print("No data")
                return
            }
            
            if (statusCode == 200) { //remove this line
            let newData = data.subdataWithRange(NSMakeRange(5, data.length - 5)) /* subset response data! */
            //print("New Data: \(newData)")
            //print(NSString(data: newData, encoding: NSUTF8StringEncoding))

            let parsedResult: AnyObject!
            do {
                parsedResult = try NSJSONSerialization.JSONObjectWithData(newData, options: .AllowFragments)
                print("parsedResult: \(parsedResult)")
            }
            catch {
                print("error")
                return
            }
            
            //print("parsedResult: \(parsedResult)")
            print("Parsed result error: \(parsedResult["error"])")
            
            guard let account = parsedResult["session"] as? NSDictionary else {
                return
            }
            print("Account: \(account)")
            self.appDelegate.sessionID = account["id"] as? String
            print("SessionID: \(self.appDelegate.sessionID)")
            
            guard let session = parsedResult["account"] as? NSDictionary else {
                return
            }
            print("Parsed result for key: \(session)")
            self.appDelegate.keyID = session["key"] as? String //Not sure if this is the correct key id
            self.appDelegate.userID = username
            self.getUserData()
            
            dispatch_async(dispatch_get_main_queue(), {
                let nc = self.storyboard!.instantiateViewControllerWithIdentifier("mapTabViewController") as! UITabBarController
                self.presentViewController(nc, animated: true, completion: nil)
                });
        }
        }
        task.resume() */
        
    }
    
    
    func getUserData() {
        print("Key ID : \(appDelegate.keyID!)")
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
                
                self.appDelegate.fName = user["first_name"] as? String
                self.appDelegate.lName = user["last_name"] as? String
                print("First name : \(self.appDelegate.fName) AND Last Name: \(self.appDelegate.lName)")
            }
        }
        task.resume()
    }
    
    
    
    
    
    
    @IBAction func loginButton(sender: AnyObject) {
        loginPressed()
    }
  

}

