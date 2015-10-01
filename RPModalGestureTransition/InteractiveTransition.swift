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
    
    init(attachedViewController: UIViewController) {
        super.init()
        
        self.attachedViewController = attachedViewController
        
        let presentationPanGesture = UIPanGestureRecognizer()
        presentationPanGesture.addTarget(self, action: "dismissalPanGesture:")
        attachedViewController.view.addGestureRecognizer(presentationPanGesture)
    }
    
    func dismissalPanGesture(recognizer: UIPanGestureRecognizer) {
        
        var progress = abs(recognizer.translationInView(attachedViewController.view).y) / attachedViewController.view.bounds.size.height
        progress = min(1.0, max(0.0, progress))
        print(progress)
        
        isInteractiveDissmalTransition = recognizer.state == .Began || recognizer.state == .Changed
        
        switch recognizer.state {
        case .Began:
            attachedViewController.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            updateInteractiveTransition(progress)
            
        case .Cancelled, .Ended:
            
            if progress > 0.3 {
                
                finishInteractiveTransition()
                
            } else {
                
                cancelInteractiveTransition()
                
            }
            
        default:
            print("gestureRecognizer state not handled")
        }
    }

}
