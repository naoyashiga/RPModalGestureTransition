//
//  TopViewController.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/28.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class TopViewController: UIViewController, ModalViewControllerDelegate {
    var interactiveTransition: InteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openModalButtonTapped(sender: UIButton) {
        let modalVC = ModalViewController(nibName: "ModalViewController", bundle: nil)
        modalVC.modalPresentationStyle = .Custom
        modalVC.transitioningDelegate = self
//        modalVC.delegate = self
        
        presentViewController(modalVC, animated: true, completion: nil)
    }
    
    func applyInteractiveTransition(animator: InteractiveTransition) {
        interactiveTransition = animator
    }

}

extension TopViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return BackgroundPresentationController(presentedViewController: presented, presentingViewController: self)
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
        
        if let animator = interactiveTransition {
            return animator
        }
        
        return nil
    }
    
}
