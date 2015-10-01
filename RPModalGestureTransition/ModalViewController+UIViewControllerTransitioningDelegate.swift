//
//  ModalViewController+UIViewControllerTransitioningDelegate.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/10/01.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

extension ModalViewController: UIViewControllerTransitioningDelegate {

    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {

        return BackgroundPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }

    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitionAnimator(isPresenting: true)
    }

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return TransitionAnimator(isPresenting: false)
    }

    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }

    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let percentInteractiveTransition = percentInteractiveTransition else {
            return nil
        }
        
        return percentInteractiveTransition.isInteractiveDissmalTransition ? percentInteractiveTransition : nil
    }
}