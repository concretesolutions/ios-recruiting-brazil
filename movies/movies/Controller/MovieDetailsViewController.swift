//
//  MovieDetailsViewController.swift
//  movies
//
//  Created by Jacqueline Alves on 02/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var screen: MovieDetailsViewControllerScreen = MovieDetailsViewControllerScreen(frame: UIScreen.main.bounds)
    
    convenience init(viewModel: MovieDetailsViewModel) {
        self.init()
    
        self.screen.setViewModel(viewModel)
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
}
