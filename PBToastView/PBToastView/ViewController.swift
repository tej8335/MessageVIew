//
//  ViewController.swift
//  PBToastView
//
//  Created by Tej on 23/10/18.
//  Copyright © 2018 Peerbits. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.perform(#selector(showErrorMessage), with: nil, afterDelay: 3.0)
    }

    @objc func showErrorMessage() {
        
        self.view.showMessage("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s", direction: .Bottom)
    }
}

