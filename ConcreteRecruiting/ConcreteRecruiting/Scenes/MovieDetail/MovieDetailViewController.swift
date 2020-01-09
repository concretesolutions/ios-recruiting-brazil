//
//  MovieDetailViewController.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 07/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    let viewModel: MovieDetailViewModel
    
    init(with viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
        
        let detailView = MovieDetailView()
        detailView.setup(with: self.viewModel)
        
        self.view = detailView
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
