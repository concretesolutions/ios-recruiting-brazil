//
//  HomeViewController.swift
//  Movs
//
//  Created by Gabriel D'Luca on 02/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Variables
    
    let screen = MoviesViewScreen()
    
    // MARK: - ViewController life cycle
    
    override func loadView() {
        super.loadView()        
        self.view = self.screen
        self.title = "Home"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
