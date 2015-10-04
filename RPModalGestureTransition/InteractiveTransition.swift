//
//  InteractiveTransition.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/29.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var isInteractiveDissmalTransition = false
    var gestureDirection: GestureDirection = .Up
    
    private var attachedViewController = UIViewController()
    private let percentCompleteThreshold: CGFloat = 0.1 // 0 ~ 1
    
    init(attachedViewController: UIViewController) {
        super.init()
        
        self.attachedViewController = attachedViewController
        
        let presentationPanGesture = UIPanGestureRecognizer()
        presentationPanGesture.addTarget(self, action: "dismissalPanGesture:")
        attachedViewController.view.addGestureRecognizer(presentationPanGesture)
    }
    
    func dismissalPanGesture(recognizer: UIPanGestureRecognizer) {
        
        isInteractiveDissmalTransition = recognizer.state == .Began || recognizer.state == .Changed
        
        switch recognizer.state {
        case .Began: panGestureBegan(recognizer)
        case .Changed: panGestureChanged(recognizer)
        case .Cancelled, .Ended: panGestureCancelledAndEnded(recognizer)
        default: ()
        }
    }
    
    override func cancelInteractiveTransition() {
        completionSpeed = percentCompleteThreshold
        super.cancelInteractiveTransition()
    }
    
    override func finishInteractiveTransition() {
        completionSpeed = 1.0 - percentCompleteThreshold
        super.finishInteractiveTransition()
    }
    
    private func panGestureBegan(recognizer: UIPanGestureRecognizer) {
        gestureDirection = panGestureDirection(recognizer)
        attachedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    private func panGestureChanged(recognizer: UIPanGestureRecognizer) {
        let transition = recognizer.translationInView(attachedViewController.view)
        var progress = transition.y / attachedViewController.view.bounds.size.height
        
        switch gestureDirection {
        case .Up:
            progress = -min(1.0, max(-1.0, progress))
        case .Down:
            progress = min(1.0, max(0, progress))
        }
        
        print(progress)
        
        updateInteractiveTransition(progress)
    }
    
    private func panGestureCancelledAndEnded(recognizer: UIPanGestureRecognizer) {
        percentComplete > percentCompleteThreshold ? finishInteractiveTransition() : cancelInteractiveTransition()
    }
    
    private func panGestureDirection(recognizer: UIPanGestureRecognizer) -> GestureDirection {
        let velocity = recognizer.velocityInView(attachedViewController.view)
        
        return velocity.y <= 0 ? .Up : .Down
    }
}
