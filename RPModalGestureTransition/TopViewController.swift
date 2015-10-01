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
        presentViewController(modalVC, animated: true, completion: nil)
    }
}