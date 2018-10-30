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
    
    var interactor: MovieGridInteractor! {
        didSet {
            if (self.dataSource.viewModels.isEmpty) {
                self.interactor.fetchMovieList(page: 1)
            }
        }
    }
    
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
    
    private(set) var state: MovieGridState = .collection {
        didSet {
            var viewState: ViewState
            
            switch state {
            case .collection:
                viewState = self.collectionState
            case .error:
                viewState = self.errorState
            }
            
            self.stateMachine.enter(state: viewState)
        }
    }
    
    override func loadView() {
        let view = BlankView()
        self.view = view
        self.setup()
    }
}

// MARK: MovieGridViewOutput
extension MovieGridViewController: MovieGridViewOutput {
    
    func display(movies: [MovieGridViewModel]) {
        self.dataSource.viewModels = movies
        self.collection.reloadData()
        
        self.state = .collection
    }
    
    func displayNetworkError() {
        self.state = .error
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
}


// MARK: State management
extension MovieGridViewController {
    enum MovieGridState {
        case collection
        case error
    }
}
