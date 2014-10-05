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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.nameLabel.text = User.currentUser!.name
        self.screenName.text = "@" + User.currentUser!.screenname!
        
        let layer = self.avatarImageView.layer
        layer.masksToBounds=true
        layer.cornerRadius=8.0
        
        if let imageURL: String = User.currentUser!.profileImageURL {
            
            self.avatarImageView.setImageWithURL(NSURL(string: imageURL))
            
        }
        
        self.tagline.text = User.currentUser!.tagline
        
    }

  
}
