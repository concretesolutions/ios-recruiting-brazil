//
//  ViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 14/11/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        APIManager.shared.getAllMovies { (objects, error) in
            print(objects)
        }
    }


}

