//
//  MovieDetailViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, ViewCodable {
    private let viewModel: MovieViewModel
    private lazy var movieDetailView = MovieDetailView(viewModel: viewModel)
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupView()
        
        view.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        view.addSubview(movieDetailView)
    }
    
    func addConstraints() {
        movieDetailView.layout.fill(view: view.safeAreaLayoutGuide)
    }
}
