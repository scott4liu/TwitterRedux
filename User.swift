//
//  Account.swift
//  TwitterMobile
//
//  Created by Scott Liu on 9/26/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

let CURRENT_USER_KEY = "KEY_USER"
var _currentUser : User?

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageURL: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var followers_count: Int = 0
    var friends_count: Int = 0
    var statuses_count: Int = 0
    
    var profile_banner_url: String?
    
    var current_Tweet: Tweet?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        profileImageURL = dictionary["profile_image_url"] as? String
        profile_banner_url = dictionary["profile_banner_url"] as? String
        tagline = dictionary["description"] as? String
        followers_count = dictionary["followers_count"] as Int
        friends_count = dictionary["friends_count"] as Int
        statuses_count = dictionary["statuses_count"] as Int
        
        //println(dictionary)
    }
    
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(CURRENT_USER_KEY) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser;
        }
        set(user) {
            _currentUser = user
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: CURRENT_USER_KEY)
            }
            else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: CURRENT_USER_KEY)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    
    }
    
    
}
