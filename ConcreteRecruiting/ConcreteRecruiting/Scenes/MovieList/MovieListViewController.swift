//
//  ViewController.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    let viewModel: MovieListViewModel
    
    init(with viewModel: MovieListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = viewModel.title
        
        self.viewModel.openDetailsScreen = { (viewModel) in
            let detailViewController = MovieDetailViewController(with: viewModel)
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
        
        let movieView = MovieListView()
        movieView.setup(with: self.viewModel)
        view = movieView
        
    }

}
