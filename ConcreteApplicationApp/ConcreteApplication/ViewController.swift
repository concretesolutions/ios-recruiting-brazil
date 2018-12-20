//
//  ViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 14/11/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let tmdbManager = TMDBManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tmdbManager.getGenres { (genres) in
            print(genres)
        }
    }
    
}

