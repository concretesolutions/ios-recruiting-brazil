//
//  MoviesListViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class MoviesListViewController: UIViewController {
    let viewModel: MoviesListViewModel
    lazy var moviesListView = MoviesListView(viewModel: viewModel, cellsManipulator: MovieListPresentationManager(modes: [
        MovieListPresentationMode(
            cellType: MinimizedMovieCollectionCell.self,
            iconImage: UIImage(named: "grid"),
            numberOfColumns: 3, heightFactor: 1.5
        ),
        MovieListPresentationMode(
            cellType: MaximizedMovieCollectionCell.self,
            iconImage: UIImage(named: "expanded"),
            numberOfColumns: 1, heightFactor: 1.3
        )
    ]))
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        view.addSubViews(moviesListView)
        
        moviesListView.layout.group
        .top(10).left(10).right(-10).bottom
        .fill(to: view.safeAreaLayoutGuide)
    }
}
 
