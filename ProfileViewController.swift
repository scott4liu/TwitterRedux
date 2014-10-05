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
    
    @IBOutlet weak var backBtnItem: UIBarButtonItem!
    
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
        

        self.nameLabel.text = user.name
        self.screenName.text = "@" + user.screenname!
        
        let layer = self.avatarImageView.layer
        layer.masksToBounds=true
        layer.cornerRadius=8.0
        
        if let imageURL: String = user.profileImageURL {
            
            self.avatarImageView.setImageWithURL(NSURL(string: imageURL))
            
        }
        
        self.tagline.text = user.tagline
        
        //clear
        User.currentUser?.current_Tweet = nil
        
    }

  
    @IBAction func back(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
