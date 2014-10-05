//
//  TwittTableViewCell.swift
//  TwitterMobile
//
//  Created by Scott Liu on 9/27/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    var _tweet: Tweet!
    
    @IBOutlet weak var topSpaceConstraint: NSLayoutConstraint!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reTweetBy: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var replyButton: UIButton!
    
       override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var tweet: Tweet {
        get {
            return self._tweet
        }
        set(tweet) {
            self._tweet = tweet;
            displayValuesForCell(tweet)
        }
    }
    
    func dispalyTweet(tweet: Tweet){
        
        self.tweetText.text = tweet.text
        
        self.nameLabel.text = tweet.user?.name
        self.screenName.text = "@" + tweet.user!.screenname!
        
        let layer = self.avatarImageView.layer
        layer.masksToBounds=true
        layer.cornerRadius=8.0
        
        if let imageURL: String = tweet.user?.profileImageURL {
            
            self.avatarImageView.setImageWithURL(NSURL(string: imageURL))
            
        }
        
    }

    
    func displayValuesForCell(tweet: Tweet) {
        if tweet.retweeted_status != nil {
            self.reTweetBy.text = "@" + tweet.user!.screenname!+" retweeted"
            self.topSpaceConstraint.constant = 18
            dispalyTweet(tweet.retweeted_status!)
        } else {
            self.reTweetBy.text = ""
            self.topSpaceConstraint.constant = 3
            dispalyTweet(tweet)
        }
       
        showFavoriteBtn(tweet)
        
        showRetweetBtn(tweet)
        
        self.timeLabel.text = tweet.timeIntervalAsStr
        
    }
    
    func showRetweetBtn(tweet: Tweet){
        if (tweet.retweeted) {
            self.retweetButton.setImage(image_retweet_on, forState: .Normal)
        } else {
            self.retweetButton.setImage(image_retweet_off, forState: .Normal)
        }
        
        self.retweetButton.setTitle(" "+String(tweet.retweet_count ?? 0), forState: .Normal)
    }
    
    func showFavoriteBtn(tweet: Tweet){
        if (tweet.favorited) {
            self.favoriteButton.setImage(image_favorite_on, forState: .Normal)
        } else {
            self.favoriteButton.setImage(image_favorite_off, forState: .Normal)
        }
        self.favoriteButton.setTitle(" "+String(tweet.favorite_count ?? 0), forState: .Normal)
    }


}
