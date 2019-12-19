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
        
        blaView.layout.build {
            $0.width.equal(to: 150)
            $0.height.equal(to: 150)
            $0.centerY.equalToSuperView()
            $0.centerX.equalToSuperView()
        }
        
        view.backgroundColor = .red
    }
}

