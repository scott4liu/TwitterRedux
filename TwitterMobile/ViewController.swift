//
//  ViewController.swift
//  TwitterMobile
//
//  Created by Scott Liu on 9/26/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

let image_favorite_on = UIImage(named: "like_on.png");
let image_favorite_off = UIImage(named: "like_off.png");
let image_retweet_on = UIImage(named: "retweet_on.png");
let image_retweet_off = UIImage(named: "retweet_off.png");

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tweets: [Tweet]?
    var prototypeCell: TweetTableViewCell?
    
    var refreshControl: UIRefreshControl!
    

    @IBOutlet weak var tweetsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl.attributedTitle = NSAttributedString(string: "Reloading Tweets ...")
        self.refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tweetsTableView.addSubview(refreshControl)
        
        //for ios 8.0
        //tweetsTableView.rowHeight = UITableViewAutomaticDimension
        
        loadHomeTimeline(nil)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tweetsTableView.reloadData()
    }
    
    func loadHomeTimeline(parameters: NSDictionary?)
    {
        TwitterClient.sharedInstance.loadHomeTimeline(parameters){ (tweetArray, error) -> () in
            if (tweetArray != nil) {
                if parameters != nil && self.tweets != nil {
                    for each in tweetArray! {
                        self.tweets!.append(each)
                    }
                } else {
                    self.tweets = tweetArray
                }
                self.tweetsTableView.reloadData()
            } else {
                println(error)
            }
        }
    }
    
    func refresh(sender:AnyObject)
    {
        loadHomeTimeline(nil)
        self.refreshControl.endRefreshing()
    }


    @IBAction func logout(sender: AnyObject) {
        
        TwitterClient.sharedInstance.logout()
        
    }
 
    func didTab(sender: UITapGestureRecognizer) {
        
        if let index = sender.view?.tag {
            
            //println(index)
            
            User.currentUser?.current_Tweet = tweets?[index]
            
            let profileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ProfileViewController") as UIViewController
            self.presentViewController(profileVC, animated: true, completion: nil)
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell") as TweetTableViewCell
        
        if let tweet = tweets?[indexPath.row] {
            cell.tweet = tweet
            
            //infinite scroll
            if (indexPath.row == (self.tweets!.count-1) ) {
                let parameters = ["max_id": tweet.id, "count": 20]
                loadHomeTimeline(parameters)
            }
        }
        
        let singleTap = UITapGestureRecognizer(target: self, action: "didTab:");
        singleTap.numberOfTapsRequired = 1;
        cell.avatarImageView.addGestureRecognizer(singleTap);
        cell.avatarImageView.tag = indexPath.row
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.tweets != nil) {
            return self.tweets!.count;
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var baseHight :CGFloat = 70.0;
        
        var line: Int = 0
        if let tweet = tweets?[indexPath.row] {
            if tweet.retweeted_status != nil {
                baseHight = 85.0
            }
            line = tweet.text_length/36
        }
        baseHight = baseHight + 12.0*CGFloat(line)
        
        return CGFloat(baseHight);
    }
    
    @IBAction func didTouchLikeButton(sender: UIButton) {
    
        if let cell = sender.superview?.superview?.superview as? TweetTableViewCell {
            
            let tweet = cell.tweet
            if !tweet.favorited {
                tweet.favorite()
            } else {
                tweet.unfavorite()
            }
            cell.showFavoriteBtn(tweet)
        }
    }
    
    @IBAction func replyToTweet(sender: AnyObject) {
        let btn = sender as UIButton
        if let cell = btn.superview?.superview?.superview as? TweetTableViewCell {
            let tweet = cell.tweet
            
            User.currentUser?.current_Tweet = tweet
            
            self.performSegueWithIdentifier("HomeToNewTweet", sender: self)
        }
        
    }
    
    @IBAction func reTweet(sender: AnyObject) {
        let btn = sender as UIButton
        if let cell = btn.superview?.superview?.superview as? TweetTableViewCell {
            
            let tweet = cell.tweet
            if !tweet.retweeted {
                tweet.reTweet()
                cell.showRetweetBtn(tweet)
            }
        }
        
    }
    
    


    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let tweet = tweets?[indexPath.row] {
            User.currentUser?.current_Tweet = tweet
            self.performSegueWithIdentifier("HomeTimelineToOneTweet", sender: self)
        }
    }
}

