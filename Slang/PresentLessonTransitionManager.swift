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
        let containerView = transitionContext.containerView()
        
        // Set Initial Conditons
        
        var frame = containerView.frame
        fromVC.view.frame = frame
        
        frame.origin.x += frame.size.width
        toVC.view.frame = frame
        toVC.view.transform = CGAffineTransformMakeScale(0.5, 0.5)
        toVC.view.userInteractionEnabled = false
        
        // Configure Container
        
        containerView.backgroundColor = UIColor.PrimaryBrandColor()
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view)
        
        // Create POP Animations
        
        let scaleDownFromView = createScaleAnimation(size: CGSizeMake(0.5, 0.5))
        let fromViewXTranslation = createXTranslationAnimation(translation: -containerView.frame.width)
        
        let scaleUpToView = createScaleAnimation(size: CGSizeMake(1.0, 1.0))
        let toViewXTranslation = createXTranslationAnimation(translation: -containerView.frame.width)
        
        // Start Animation
    
        fromVC.view.layer.pop_addAnimation(scaleDownFromView, forKey: "scale")
        fromVC.view.layer.pop_addAnimation(fromViewXTranslation, forKey: "xTranslation")
        
        toVC.view.layer.pop_addAnimation(scaleUpToView, forKey: "scale")
        toVC.view.layer.pop_addAnimation(toViewXTranslation, forKey: "xTranslation")
        
        delay(animationDuration) {
            toVC.view.userInteractionEnabled = true
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return animationDuration
    }
    
    // MARK: Utility Functions
    
    func createScaleAnimation(#size: CGSize) -> POPBasicAnimation  {
        let scaleXYAnim = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleXYAnim.duration = 0.5
        scaleXYAnim.toValue = NSValue(CGSize: size)
        return scaleXYAnim
    }
    
    func createXTranslationAnimation(#translation: CGFloat) -> POPBasicAnimation  {
        let xTranslateAnim = POPBasicAnimation(propertyNamed: kPOPLayerTranslationX)
        xTranslateAnim.duration = 0.5
        xTranslateAnim.toValue = translation
        return xTranslateAnim
    }
}
