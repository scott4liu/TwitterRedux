//
//  ContainerViewController.swift
//  TwitterMobile
//
//  Created by Scott Liu on 10/3/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var contentXconstaint: NSLayoutConstraint!
    
    
    @IBOutlet weak var menuViewXconstraint: NSLayoutConstraint!
    
    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    var activeViewController: UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
                
            }
            
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.menuViewXconstraint.constant -= 260
        self.contentView.layer.zPosition = 10
        let nav = mainStoryboard.instantiateViewControllerWithIdentifier("TimelineNavigationController") as UIViewController

     
        self.contentXconstaint.constant = 0
        self.activeViewController = nav
        // Do any additional setup after loading the view.
    }
    
    /*
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        //println(touch)
        let location = touch.locationInView(self.contentView)
            if location.x < 53 &&  location.x > 0 {
                return true
            } else {
                return false
            }
        
        
    }
    */

    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        
        if sender.state == .Ended  {
            if sender.direction == UISwipeGestureRecognizerDirection.Right {
                
                self.menuViewXconstraint.constant += 260
                
                UIView.animateWithDuration(0.35, animations: { () -> Void in
                    self.contentXconstaint.constant = -260
                    self.view.layoutIfNeeded()
                })

                
            }
            else if sender.direction == UISwipeGestureRecognizerDirection.Left {
                
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.contentXconstaint.constant = 0
                    self.view.layoutIfNeeded()
                    }, completion: { (Bool) -> Void in
                    self.menuViewXconstraint.constant -= 260
                        
                })
               
            }

        }
    }
    
    
    
}
