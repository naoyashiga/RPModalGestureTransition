//
//  InteractiveTransition.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/29.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

protocol InteractiveTransitionDelegate {
    func setup() -> InteractiveTransition
}

class InteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    var delegate: InteractiveTransitionDelegate?
    private var parentViewController = UIViewController()
    private let percentageAdjustFactor: CGFloat = 2.5
    
    func attachToViewController(viewController: UIViewController) {
        
        parentViewController = viewController
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanRecognizer:")
        
        parentViewController.view.addGestureRecognizer(panRecognizer)
    }
    
    func handlePanRecognizer(recognizer: UIPanGestureRecognizer) {
        
        print(recognizer.translationInView(parentViewController.view).y)
        var progress = recognizer.translationInView(parentViewController.view).y / parentViewController.view.bounds.size.height / percentageAdjustFactor
        progress = min(1.0, max(0.0, progress))
        
        
        switch recognizer.state {
        case .Began:
            parentViewController.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
            
        case .Changed:
            updateInteractiveTransition(progress)
            
        default:
            
            if recognizer.velocityInView(parentViewController.view).y >= 0 {
                
                finishInteractiveTransition()
                parentViewController.view.removeGestureRecognizer(recognizer)
                
            } else {
                
                cancelInteractiveTransition()
                
            }
            
            break;
        }
    }
    
}
