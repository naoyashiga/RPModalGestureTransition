//
//  ModalViewController.swift
//  RPModalGestureTransition
//
//  Created by naoyashiga on 2015/09/28.
//  Copyright © 2015年 naoyashiga. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate {
    func applyInteractiveTransition(animator: InteractiveTransition)
}

class ModalViewController: UIViewController {
//    var delegate: ModalViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let interactiveTransition = InteractiveTransition()
//        interactiveTransition.attachToViewController(self)
//        
//        delegate?.applyInteractiveTransition(interactiveTransition)
        
        modalPresentationStyle = .Custom
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTapped(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
