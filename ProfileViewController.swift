//
//  ProfileViewController.swift
//  TwitterMobile
//
//  Created by Scott Liu on 10/4/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var backBtnItem: UIBarButtonItem!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var friendCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.currentUser?.current_Tweet != nil {
            self.user = User.currentUser?.current_Tweet!.user
        } else {
            self.user = User.currentUser!
            self.backBtnItem.title = ""
            self.backBtnItem.width = 0
        }
        
        if let banner_url = user.profile_banner_url {
            self.backgroundImageView.setImageWithURL(NSURL(string: banner_url))
        }
        //self.backgroundImageView.layer.zPosition = -1
        self.nameLabel.text = user.name
        self.screenName.text = "@" + user.screenname!
        
        let layer = self.avatarImageView.layer
        layer.masksToBounds=true
        layer.cornerRadius=8.0
        
        if let imageURL: String = user.profileImageURL {
            
            self.avatarImageView.setImageWithURL(NSURL(string: imageURL))
            
        }
        
        self.tagline.text = user.tagline
        
        self.tweetCount.text = String(user.statuses_count)
        self.followerCount.text = String(user.followers_count)
        self.friendCount.text = String(user.friends_count)
        
        //clear
        User.currentUser?.current_Tweet = nil
        
    }

  
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
