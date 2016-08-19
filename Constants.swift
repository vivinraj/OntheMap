//
//  Constants.swift
//  OntheMaps
//
//  Created by vivin raj on 18/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//



import UIKit

// MARK: - Constants
struct Constants {
    
    
    static let ParseBaseURL = "https://api.parse.com/1/classes/StudentLocation"
    
    static let ParseBasicURL = "https://api.parse.com/1/classes/StudentLocation"
    static let udacityBaseURL = "https://udacity.com/api"
    
    // MARK: - JSON Body Keys
    struct JSONBodyKeys {
        // udacity
        static let Udacity = "udacity"
        static let Username = "username"
        static let Password = "password"
        
        // parse
        static let UniqueKey = "uniqueKey"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let ObjectID = "objectID"
    }
    
    struct JSONResponseKeys {
        
        static let CreatedAt = "createdAt"
        static let FirstName = "firstName"
        static let LastName = "lastName"
        static let Latitude = "latitude"
        static let Longitude = "longitude"
        static let MapString = "mapString"
        static let MediaURL = "mediaURL"
        static let ObjectID = "objectId"
        static let Results = "results"
        
    }
}

struct Student {
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let mapString = "mapString"
    static let mediaURL = "mediaURL"
    static let results = "results"
    static let objectID = "objectId"
    static let uniqueKey = "uniqueKey"
    
}

