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
    private let presentationManager: MovieListPresentationManager
    lazy var moviesListView = MoviesListView(viewModel: viewModel, presentationManager: self.presentationManager)
    
    init(viewModel: MoviesListViewModel, presentationManager: MovieListPresentationManager) {
        self.viewModel = viewModel
        self.presentationManager = presentationManager
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
 
