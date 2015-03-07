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
    let minNavigationBarHeight: CGFloat = 64.0
    let maxNavigationBarHeight: CGFloat = 128.0
    
    lazy var navigationBar: NavigationBar = {
        let navigationBar = NavigationBar(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.maxNavigationBarHeight))
        navigationBar.backgroundColor = UIColor.PrimaryBrandColor()
        navigationBar.message = "What will you learn today?".uppercaseString
        return navigationBar
    }()
    
    lazy var tableView: UITableView = {
        let width = CGRectGetWidth(self.view.frame)
        let height = CGRectGetHeight(self.view.frame) - self.maxNavigationBarHeight
        let tableView = UITableView(frame: CGRectMake(0, self.maxNavigationBarHeight, width, height))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0)
        tableView.registerClass(LessonListTableViewCell.self, forCellReuseIdentifier: self.CellIdentifier)
        tableView.estimatedRowHeight = 100.0
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(navigationBar)
        view.addSubview(tableView)
    }
}

extension LessonListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as LessonListTableViewCell
        cell.title = "Learning Slang"
        cell.desc = "Learn the basics of how the Slang Language works."
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let vc = SlangViewController()
        vc.modalPresentationStyle = .Custom
        vc.transitioningDelegate = self
        presentViewController(vc, animated: true, completion:nil)
    }
}

extension LessonListViewController: UIScrollViewDelegate {
    
    func scrollView(scrollView: UIScrollView, didScrollToPercentageOffset percentageOffset: CGPoint) {
        
        if percentageOffset.y > 0 {
            
            // 2DP
            let pcgOffest = CGFloat(round(100*percentageOffset.y)/100)
            
            var newNavBarHeight = floor( (1 - pcgOffest) * 128)
            if newNavBarHeight < minNavigationBarHeight { newNavBarHeight = 64.0 }
            if newNavBarHeight > maxNavigationBarHeight { newNavBarHeight = 128.0 }
            
            navigationBar.percentageOffset = ( newNavBarHeight / minNavigationBarHeight - 1.0 )
            
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                
                var frame = self.navigationBar.frame
                frame.size.height = newNavBarHeight
                self.navigationBar.frame = frame
                
                frame = self.tableView.frame
                let tableViewHeight = CGRectGetHeight(self.view.frame) - newNavBarHeight
                frame.origin.y = newNavBarHeight
                frame.size.height = tableViewHeight
                self.tableView.frame = frame
            })
            
        } else {
            
            // Jumped to Max Height - Set to Initial State
            UIView.animateWithDuration(0.15, animations: { () -> Void in
                let frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), self.maxNavigationBarHeight)
                self.navigationBar.frame = frame
                self.navigationBar.resetToDefaultState()
                
                let width = CGRectGetWidth(self.view.frame)
                let height = CGRectGetHeight(self.view.frame) - self.maxNavigationBarHeight
                self.tableView.frame = CGRectMake(0, self.maxNavigationBarHeight, width, height)
            })
        }
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
