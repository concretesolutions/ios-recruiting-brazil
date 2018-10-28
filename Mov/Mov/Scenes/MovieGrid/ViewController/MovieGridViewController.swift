//
//  MovieListViewController.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridViewController: UIViewController {
    
    
    let dataSource = MovieGridDataSource()
    
    var interactor: MovieGridInteractor!
    
    lazy var collection: UICollectionView = {
        return self.collectionView.collection
    }()
    
    lazy var collectionView: MovieGridView = {
        return MovieGridView(dataSource: self.dataSource)
    }()
    
    lazy var errorView: MovieGridErrorView = {
       return MovieGridErrorView()
    }()
    
    lazy var collectionState: MovieGridCollectionState = {
        return MovieGridCollectionState(viewController: self)
    }()
    
    lazy var errorState: MovieGridErrorState = {
        return MovieGridErrorState(viewController: self)
    }()
    
    lazy var stateMachine: ViewStateMachine = {
       return ViewStateMachine()
    }()

    override func loadView() {
        let view = BlankView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        interactor.fetchMovieList(page: 1)
    }
}

// MARK: MovieGridViewOutput
extension MovieGridViewController: MovieGridViewOutput {
    
    func display(movies: [MovieGridViewModel]) {
        self.dataSource.viewModels = movies
        
        self.collection.reloadData()
    }
    
    func displayNetworkError() {
        self.stateMachine.enter(state: self.errorState)
    }
}

// MARK: View Code stuff
extension MovieGridViewController: ViewCode {
    func addView() {
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.errorView)
    }
    
    func addConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.stateMachine.enter(state: self.collectionState)
    }
}
