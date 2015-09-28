//
//  TopViewController.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/28.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

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
        
        presentViewController(modalVC, animated: true, completion: nil)
    }

}

extension TopViewController: UIViewControllerTransitioningDelegate {
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return BackgroundPresentationController(presentedViewController: presented, presentingViewController: self)
    }
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        let animator = TransitionPresentationAnimator()
//        animator.sourceVC = self
//        animator.destinationVC = presented
//        
//        return animator
//    }
//    
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        
//        let animator = TransitionDismissAnimator()
//        animator.sourceVC = dismissed
//        animator.destinationVC = self
//        
//        return animator
//    }
}
