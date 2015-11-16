//
//  PresentLessonTransistionManager.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/24/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit

// MARK: - PresentLessonTransitionManager Class

class PresentLessonTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties
    
    let animationDuration = 0.5
    
    // MARK: UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()!
        
        // Set Initial Conditons
        
        var frame = containerView.frame
        fromVC.view.frame = frame
        
        frame.origin.x += frame.size.width
        toVC.view.frame = frame
        toVC.view.userInteractionEnabled = false
        
        // Configure Container
        
        containerView.backgroundColor = UIColor.whiteColor()
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
        // Create POP Animations
        
        var frame2 = containerView.frame
        frame2.origin.x = -containerView.frame.width
        //frame2.size.width *= 0.8
        //frame2.size.height *= 0.8
        let frameAnim = createFrameAnimation(frame: frame2)
        _ = createScaleAnimation(from: CGSizeMake(1.0, 1.0), to: CGSizeMake(0.8, 0.8))
        _ = createXTranslationAnimation(translation: -containerView.frame.width)
        
        
        let scaleUpToView = createScaleAnimation(from: CGSizeMake(0.8, 0.8), to: CGSizeMake(1.0, 1.0))
        let toViewXTranslation = createXTranslationAnimation(translation: -containerView.frame.width)
        
        // Start Animation
    
        fromVC.view.pop_addAnimation(frameAnim, forKey: "frame")
        
        toVC.view.pop_addAnimation(scaleUpToView, forKey: "scale")
        toVC.view.layer.pop_addAnimation(toViewXTranslation, forKey: "xTranslation")
        
        delay(animationDuration) {
            toVC.view.userInteractionEnabled = true
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: Utility Functions
    
    func createScaleAnimation(from start: CGSize, to finish: CGSize) -> POPBasicAnimation  {
        let scaleXYAnim = POPBasicAnimation(propertyNamed: kPOPViewScaleXY)
        scaleXYAnim.duration = 0.5
        scaleXYAnim.fromValue = NSValue(CGSize: start)
        scaleXYAnim.toValue = NSValue(CGSize: finish)
        return scaleXYAnim
    }
    
    func createXTranslationAnimation(translation translation: CGFloat) -> POPBasicAnimation  {
        let xTranslateAnim = POPBasicAnimation(propertyNamed: kPOPLayerTranslationX)
        xTranslateAnim.duration = 0.5
        xTranslateAnim.toValue = translation
        return xTranslateAnim
    }
    
    func createFrameAnimation(frame frame: CGRect) -> POPBasicAnimation  {
        let frameAnim = POPBasicAnimation(propertyNamed: kPOPViewFrame)
        frameAnim.duration = 0.5
        frameAnim.toValue = NSValue(CGRect: frame)
        return frameAnim
    }
}
