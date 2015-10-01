//
//  TransitionAnimator.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/28.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit


class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: NSTimeInterval = 0.3
    
    private(set) weak var transitionContext: UIViewControllerContextTransitioning?
    
    private var containerView: UIView? {
        return transitionContext?.containerView()
    }
    
    private var toViewController: UIViewController? {
        return transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)
    }
    
    private var fromViewController: UIViewController? {
        return transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)
    }
    
    private let isPresenting :Bool
    
    // MARK: - Life cycle
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        if isPresenting {
            animatePresentationWithTransitionContext(transitionContext)
        } else {
            animateDismissalWithTransitionContext(transitionContext)
        }
    }
    
    private func animatePresentationWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = toViewController, containerView = containerView else {
            return
        }
        
        guard let toView = transitionContext.viewForKey(UITransitionContextToViewKey) else { return }
        
        toView.frame = transitionContext.finalFrameForViewController(toViewController)
        toView.center.y -= 300
        
        containerView.addSubview(toView)
        
        UIView.animateWithDuration(
            self.animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
                
                toView.center.y += 300
                
            }, completion: didFinishedAnimation)
    }
    
    private func animateDismissalWithTransitionContext(transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey) else { return }
        
        UIView.animateWithDuration(
            self.animationDuration,
            delay: 0.0,
            usingSpringWithDamping: 1.0,
            initialSpringVelocity: 0.5,
            options: .CurveEaseInOut,
            animations: {
            
            fromView.frame.origin.y = -fromView.bounds.height
            
            }, completion: didFinishedAnimation)
    }
    
    private func didFinishedAnimation(_:Bool) {
        guard let transitionContext = transitionContext else {
            return
        }
        
        if transitionContext.transitionWasCancelled() {
            transitionContext.completeTransition(false)
        } else {
            transitionContext.completeTransition(true)
        }
    }
}
