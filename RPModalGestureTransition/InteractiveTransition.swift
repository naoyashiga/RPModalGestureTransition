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
        case .Began:
            
            attachedViewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            dismissalPanGestureChanged(recognizer)
            
        case .Cancelled, .Ended:
            
            percentComplete > percentCompleteThreshold ? finishInteractiveTransition() : cancelInteractiveTransition()
            
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
    
    private func dismissalPanGestureChanged(recognizer: UIPanGestureRecognizer) {
        var progress = recognizer.translationInView(attachedViewController.view).y / attachedViewController.view.bounds.size.height
        progress = min(1.0, max(-1.0, progress))
        
//        print(progress)
        
        gestureDirection = panGestureDirection(recognizer)
        
        updateInteractiveTransition(abs(progress))
    }
    
    private func panGestureDirection(recognizer: UIPanGestureRecognizer) -> GestureDirection {
        let velocity = recognizer.velocityInView(attachedViewController.view)
        
        return velocity.y <= 0 ? .Up : .Down
    }
    
//    private func gestureDirectionDidChange(recognizer: UIPanGestureRecognizer) -> Bool {
//        
//    }
}
