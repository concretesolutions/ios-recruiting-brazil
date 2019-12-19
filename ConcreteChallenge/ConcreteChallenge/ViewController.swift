//
//  ViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class ViewController: UIViewController {
    let blaView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blaView)
        
        blaView.backgroundColor = .black

        
        blaView.layout.fillSuperView(withMargin: 20)
        
        
        view.backgroundColor = .red
    }
}

