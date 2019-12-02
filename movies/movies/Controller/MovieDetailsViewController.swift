//
//  MovieDetailsViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var screen: MovieDetailsViewControllerScreen!
    
    convenience init(viewModel: MovieDetailsViewModel) {
        self.init()
    
        self.screen = MovieDetailsViewControllerScreen(with: viewModel, frame: UIScreen.main.bounds)
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
