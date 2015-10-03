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
        
        var progress = -recognizer.translationInView(attachedViewController.view).y / attachedViewController.view.bounds.size.height
        progress = min(1.0, max(0.0, progress))
        
        print(progress)
        
        isInteractiveDissmalTransition = recognizer.state == .Began || recognizer.state == .Changed
        
        switch recognizer.state {
        case .Began:
            
            attachedViewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            
            updateInteractiveTransition(progress)
            
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
}
