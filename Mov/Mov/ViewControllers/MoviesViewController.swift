//
//  ViewController.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {
    
    
    let screen = MoviesViewControllerScreen()

    
    override func loadView() {
        self.view = screen
        self.view.backgroundColor = .green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}




