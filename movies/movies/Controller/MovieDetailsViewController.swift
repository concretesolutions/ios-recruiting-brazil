//
//  MovieDetailsViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    override func loadView() {
        let view = MovieDetailsViewControllerScreen(frame: UIScreen.main.bounds)
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
