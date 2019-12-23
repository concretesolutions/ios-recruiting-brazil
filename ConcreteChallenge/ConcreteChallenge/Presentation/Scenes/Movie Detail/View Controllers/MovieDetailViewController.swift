//
//  MovieDetailViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, ViewCodable {
    let viewModel: MovieViewModel
    private lazy var moviesListViewController = makeMoviesListViewController()
    private lazy var movieDetailView = MovieDetailView(viewModel: viewModel)

    var movieImageView: UIImageView {
        return self.movieDetailView.movieImageView
    }
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if let moviesListViewController = self.moviesListViewController {
            addChild(moviesListViewController, inView: view, fillingAnchorable: movieDetailView.moviesListLayoutGuide)
        }
    }
    
    func buildHierarchy() {
        view.addSubview(movieDetailView)
    }
    
    func addConstraints() {
        movieDetailView.layout.build {
            $0.top.equal(to: view.frameLayout.top)
            $0.bottom.equal(to: view.frameLayout.bottom)
            $0.left.equal(to: view.frameLayout.left)
            $0.right.equal(to: view.frameLayout.right)
        }
    }
    
    private func makeMoviesListViewController() -> MoviesListViewController? {
        guard let similarMoviesViewModel = viewModel.withSimilarOptions?.moviesListViewModel else {
            return nil
        }
        
        return MoviesListViewController(viewModel: similarMoviesViewModel, presentationManager: MovieListPresentationManager(
                modes:[
                    MovieListPresentationMode(
                        cellType: MinimizedMovieCollectionCell.self,
                        iconImage: UIImage(named: "grid"),
                        numberOfColumns: 3, heightFactor: 1.7
                    ),
                    MovieListPresentationMode(
                        cellType: MaximizedMovieCollectionCell.self,
                        iconImage: UIImage(named: "expanded"),
                        numberOfColumns: 1, heightFactor: 1
                    )
                ]
            )
        ).build {
            $0.scrollDirection = .horizontal
        }
    }
}
