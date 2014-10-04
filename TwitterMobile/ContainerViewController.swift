//
//  ContainerViewController.swift
//  TwitterMobile
//
//  Created by Scott Liu on 10/3/14.
//  Copyright (c) 2014 Scott. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var contentXconstaint: NSLayoutConstraint!
    
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
        
        let nav = mainStoryboard.instantiateViewControllerWithIdentifier("TimelineNavigationController") as UIViewController

     
        self.contentXconstaint.constant = 0
        self.activeViewController = nav
        // Do any additional setup after loading the view.
    }

    
    
}
