//
//  MovieListViewController.swift
//  ShitMov
//
//  Created by Miguel Nery on 22/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

final class MovieGridViewController: UIViewController {
    
    private static let title = "Movies"
    
    var interactor: MovieGridInteractor! {
        didSet {
            if (self.viewModels.isEmpty) {
                self.interactor.fetchMovieList(page: self.page)
            }
        }
    }
    
    private(set) var viewModels = [MovieGridViewModel]()
    
    private(set) var page = 1
    
    lazy var movieGridView: MovieGridView = {
        let movieGridView = MovieGridView()
        movieGridView.collection.dataSource = self
        movieGridView.collection.delegate = self
        return movieGridView
    }()
    
    lazy var collectionState: MovieGridCollectionState = {
        return MovieGridCollectionState(movieGridView: self.movieGridView)
    }()
    
    lazy var errorState: MovieGridErrorState = {
        return MovieGridErrorState(movieGridView: self.movieGridView)
    }()
    
    lazy var noResultsState: MovieGridNoResultsState = {
        return MovieGridNoResultsState(movieGridView: self.movieGridView)
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
            case .noResults(let request):
                self.noResultsState.searchRequest = request
                viewState = self.noResultsState
            }
            
            self.stateMachine.enter(state: viewState)
        }
    }
    
    override func loadView() {
        let view = BlankView()
        self.view = view
        self.setup()
        self.state = .collection
    }
    
    override func viewDidLoad() {
        self.setTabBarOptions()
        self.title = MovieGridViewController.title
    }
}

// MARK: MovieGridViewOutput
extension MovieGridViewController: MovieGridViewOutput {
    
    func display(movies: [MovieGridViewModel]) {
        self.viewModels = movies
        self.movieGridView.collection.reloadData()
        
        self.state = .collection
    }
    
    func displayNetworkError() {
        self.state = .error
    }
    
    func displayNoResults(for request: String) {
        self.state = .noResults(request)
    }
}

// MARK: View Code
extension MovieGridViewController: ViewCode {
    func addView() {
        self.view.addSubview(self.movieGridView)
    }
    
    func addConstraints() {
        self.movieGridView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.movieGridView.searchBarDelegate.textDidChangeAction = self.interactor.filterMoviesBy
        
        self.movieGridView.searchBarDelegate.didPressCancelAction = { [weak self] in
            guard let self = self else { return }
            
            self.state = .collection
        }
    }
}


// MARK: State management
extension MovieGridViewController {
    enum MovieGridState {
        case collection
        case error
        case noResults(String)
    }
}

// MARK: UI actions
extension MovieGridViewController {
    
    func didTapFavorite(button: UIButton) {
        let position = button.convert(CGPoint.zero, to: self.movieGridView.collection.coordinateSpace)
        let indexPath = self.movieGridView.collection.indexPathForItem(at: position)
        
        if let indexPath = indexPath {
            self.interactor.toggleFavoriteMovie(at: indexPath.item)
        }
    }
}

// MARK: TabBar setup
extension MovieGridViewController {
    func setTabBarOptions() {
        self.tabBarItem = UITabBarItem(title: MovieGridViewController.title,
                                       image: Images.movieListIcon, tag: 0)
    }
}

extension MovieGridViewController: MovieDetailsNavigator {
    
    func navigateToDetailsView(of movie: Movie) {
        let detailsVC = MovieDetailsBuilder.build(forMovie: movie)
        show(detailsVC, sender: nil)
    }
    
    
}
