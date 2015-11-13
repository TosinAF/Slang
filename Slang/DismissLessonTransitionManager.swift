//
//  DismissLessonTransitionManager.swift
//  Slang
//
//  Created by Tosin Afolabi on 2/25/15.
//  Copyright (c) 2015 Tosin Afolabi. All rights reserved.
//

import pop
import UIKit

// MARK: - DismissLessonTransitionManager Class

class DismissLessonTransitionManager: NSObject, UIViewControllerAnimatedTransitioning {
    
    // MARK: Properties
    
    let animationDuration = 0.5
    
    // MARK: UIViewControllerAnimatedTransitioning Methods
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let containerView = transitionContext.containerView()
        
        // Set Initial Conditons
        
        var frame = containerView!.frame
        frame.origin.x  = -containerView!.frame.size.width / 2
        toVC.view.frame = frame
        toVC.view.userInteractionEnabled = false
        
        // Configure Container
        
        containerView!.backgroundColor = UIColor.whiteColor()
        containerView!.addSubview(toVC.view)
        containerView!.addSubview(fromVC.view)
        
        // Create POP Animations
        
        let fromViewXTranslation = createXTranslationAnimation(translation: containerView!.frame.width)
        let scaleDownFromView = createScaleAnimation(from: CGSizeMake(1.0, 1.0), to: CGSizeMake(0.8, 0.8))
        
        let scaleUpToView = createScaleAnimation(from: CGSizeMake(0.8, 0.8), to: CGSizeMake(1.0, 1.0))
        let frameAnim = createFrameAnimation(frame: containerView!.frame)
        
        // Start Animation
        
        fromVC.view.layer.pop_addAnimation(scaleDownFromView, forKey: "scale")
        fromVC.view.layer.pop_addAnimation(fromViewXTranslation, forKey: "xTranslation")
        
        toVC.view.layer.pop_addAnimation(scaleUpToView, forKey: "scale")
        toVC.view.pop_addAnimation(frameAnim, forKey: "frame")
        
        delay(animationDuration) {
            toVC.view.userInteractionEnabled = true
            transitionContext.completeTransition(true)
            
            // iOS 8 Bug ->
            // http://joystate.wordpress.com/2014/09/02/ios8-and-custom-uiviewcontrollers-transitions/
            UIApplication.sharedApplication().keyWindow!.addSubview(toVC.view)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: Utility Functions
    
    func createScaleAnimation(from start: CGSize, to final: CGSize) -> POPBasicAnimation  {
        let scaleXYAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleXYAnim.duration = 0.5
        scaleXYAnim.fromValue = NSValue(CGSize: start)
        scaleXYAnim.toValue = NSValue(CGSize: final)
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

