//
//  Constants.swift
//  OntheMaps
//
//  Created by vivin raj on 01/08/16.
//  Copyright © 2016 vivin raj. All rights reserved.
//

import Foundation

import UIKit

struct Constants {
    
    static let ParseBasicURL = "https://api.parse.com/1/classes/StudentLocation"
    static let udacityBaseURL = "https://udacity.com/api"
    
    
  
    // MARK: Flickr Parameter Keys
    struct JSONParameterKeys {
    static let objectID = "objectID"
    static let uniqueKey = "uniqueKey"
    static let firstName = "firstname"
    static let lastName = "lastName"
    static let mapString = "mapString"
    static let mediaURL = "mediaURL"
    static let latitude = "latitude"
    static let longitude = "longitude"
    static let createdAt = "createdAt"
    static let updatedAt = "updatedAt"
    static let ACL = "ACL"
    }
    
    // MARK: Flickr Parameter Values
    struct JSONParameterValues {
    static let SearchMethod = "flickr.photos.search"
    static let APIKey = "YOUR_API_KEY_HERE"
    static let ResponseFormat = "json"
    static let DisableJSONCallback = "1" /* 1 means "yes" */
    static let GalleryPhotosMethod = "flickr.galleries.getPhotos"
    static let GalleryID = "5704-72157622566655097"
    static let MediumURL = "url_m"
    static let UseSafeSearch = "1"
    }
    
    // MARK: Flickr Response Keys
    struct JSONResponseKeys {
    static let Status = "stat"
    static let Photos = "photos"
    static let Photo = "photo"
    static let Title = "title"
    static let MediumURL = "url_m"
    static let Pages = "pages"
    static let Total = "total"
    }
    
    // MARK: Flickr Response Values
    struct FlickrResponseValues {
    static let OKStatus = "ok"
    }
    
    // FIX: As of Swift 2.2, using strings for selectors has been deprecated. Instead, #selector(methodName) should be used.
    /*
     // MARK: Selectors
     struct Selectors {
     static let KeyboardWillShow: Selector = "keyboardWillShow:"
     static let KeyboardWillHide: Selector = "keyboardWillHide:"
     static let KeyboardDidShow: Selector = "keyboardDidShow:"
     static let KeyboardDidHide: Selector = "keyboardDidHide:"
     }
     */
    
    
    
    }

