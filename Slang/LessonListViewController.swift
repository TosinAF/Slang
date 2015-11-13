//
//  LessonListViewController.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/21/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import UIKit
import Cartography

class LessonListViewController: UIViewController {
    
    let CellIdentifier = "LessonCell"
    
    lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "SlangLogo-Filled")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.SecondaryBrandColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        tableView.registerClass(LessonListTableViewCell.self, forCellReuseIdentifier: self.CellIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        view.addSubview(logoImageView)
        view.addSubview(seperatorView)
        view.addSubview(tableView)
        
        layoutSubviews()
    }
    
    
    func layoutSubviews() {
    
        constrain(logoImageView) { logoImageView in
            logoImageView.centerX == logoImageView.superview!.centerX
            logoImageView.top == logoImageView.superview!.top + 24
        }
        
        constrain(seperatorView) { seperatorView in
            seperatorView.width == seperatorView.superview!.width - 30
            seperatorView.left == seperatorView.superview!.left + 15
            seperatorView.top == seperatorView.superview!.top + 64
            seperatorView.height == 2
        }
        
        constrain(tableView, seperatorView) { tableView, seperatorView in
            tableView.top == seperatorView.bottom
            tableView.bottom == tableView.superview!.bottom
            tableView.width == tableView.superview!.width
        }
    }
}

extension LessonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as! LessonListTableViewCell
        cell.title = "Learning Slang"
        cell.desc = "Learn the basics of how the Slang Language works."
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SlangViewController()
        vc.modalPresentationStyle = .Custom
        vc.transitioningDelegate = self
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.presentViewController(vc, animated: true, completion:nil)
        })
    }
}

extension LessonListViewController: UIScrollViewDelegate {
    
    func scrollView(scrollView: UIScrollView, didScrollToPercentageOffset percentageOffset: CGPoint) {

    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let maximumHorizontalOffset = scrollView.contentSize.width - CGRectGetWidth(scrollView.frame);
        let currentHorizontalOffset = scrollView.contentOffset.x;
        
        let maximumVerticalOffset = scrollView.contentSize.height - CGRectGetHeight(scrollView.frame);
        let currentVerticalOffset = scrollView.contentOffset.y;
        
        let percentageHorizontalOffset = currentHorizontalOffset / maximumHorizontalOffset;
        let percentageVerticalOffset = currentVerticalOffset / maximumVerticalOffset;
        
        self.scrollView(scrollView, didScrollToPercentageOffset: CGPointMake(percentageHorizontalOffset, percentageVerticalOffset))
    }
}

// MARK: - Transitioning Delegate

extension LessonListViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentLessonTransitionManager()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissLessonTransitionManager()
    }
}
