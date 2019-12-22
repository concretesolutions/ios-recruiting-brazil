//
//  PopularMoviesViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class PopularMoviesViewController: UIViewController, ViewCodable {
    var viewModel: MoviesListViewModel
    private lazy var moviesListViewController = MoviesListViewController(viewModel: self.viewModel)
    private let moviesListLayoutGuide = UILayoutGuide()
    
    init(viewModel: MoviesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addChild(moviesListViewController, inView: view, fillingAnchorable: moviesListLayoutGuide)
    }
    
    func buildHierarchy() {
        view.addLayoutGuide(moviesListLayoutGuide)
    }
       
    func addConstraints() {
        moviesListLayoutGuide.layout.group
            .top(10).left(10).right(-10).bottom
            .fill(to: view.safeAreaLayoutGuide)
    }
}
