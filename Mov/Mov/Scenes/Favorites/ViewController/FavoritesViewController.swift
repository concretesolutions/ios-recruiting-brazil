//
//  FavortiesViewController.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    static let title = "Favorites"
    
    private(set) var viewModels = [FavoritesViewModel]()
    
    var interactor: FavoritesInteractor? {
        didSet {
            if let _ = self.interactor, self.viewModels.isEmpty {
                self.fetchFavorites()
            } else {
                self.state = .fetchError
            }
        }
    }
    
    let stateMachine: ViewStateMachine = ViewStateMachine()
    
    var state: FavoritesState = .tableView {
        didSet {
            let state: ViewState
            
            switch self.state {
            case .tableView:
                state = self.tableViewState
            case .noResults(let request):
                self.noResultState.searchRequest = request
                state = self.noResultState
            case .fetchError:
                state = self.fetchErrorState
            }
            
            self.stateMachine.enter(state: state)
        }
    }
    
    lazy var tableViewState: FavoritesTableViewState = {
        return FavoritesTableViewState(favoritesView: self.favoritesView)
    }()
    
    lazy var noResultState: FavoritesNoResultState = {
        return FavoritesNoResultState(favoritesView: self.favoritesView)
    }()
    
    lazy var fetchErrorState: FavoritesFethErrorState = {
        return FavoritesFethErrorState(favoritesView: self.favoritesView)
    }()
    
    lazy var favoritesView: FavoritesView = {
        return FavoritesView(frame: .zero)
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.setTabBarOptions()
        self.state = .tableView
        self.title = FavoritesViewController.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = BlankView()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchFavorites()
    }
}

extension FavoritesViewController: ViewCode {
    func addView() {
        self.view.addSubview(self.favoritesView)
    }
    
    func addConstraints() {
        self.favoritesView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func additionalSetup() {
        self.favoritesView.tableView.dataSource = self
        self.favoritesView.tableView.delegate = self
        
        self.favoritesView.searchBarDelegate.textDidChangeAction = self.interactor!.filterMoviesBy
    }
}

extension FavoritesViewController: FavoritesViewOutput {
    func display(movies: [FavoritesViewModel]) {
        self.viewModels = movies
        self.favoritesView.tableView.reloadData()
        
        self.state = .tableView
    }
    
    func displayNoResults(for request: String) {
        self.state = .noResults(request)
    }
    
    func displayFetchError() {
        self.state = .fetchError
    }
    
    func displayFavoritesError() {
        self.present(UICommon.favoritesErrorAlert, animated: true, completion: nil)
    }
}

// MARK: TabBar setup
extension FavoritesViewController {
    func setTabBarOptions() {
        self.tabBarItem = UITabBarItem(title: FavoritesViewController.title,
                                       image: Images.favoritesIcon, tag: 1)
    }
}

// MARK: View Input
extension FavoritesViewController {
    func fetchFavorites() {
        guard let interactor = self.interactor else {
            self.displayFetchError()
            return
        }
        
        interactor.fetchFavorites()
    }
}


// MARK: State management
extension FavoritesViewController {
    enum FavoritesState: Equatable {
        case tableView
        case fetchError
        case noResults(String)
    }
}

extension FavoritesViewController: MovieDetailsNavigator {
    func navigateToDetailsView(of movie: Movie) {
        let detailsVC = MovieDetailsBuilder.build(forMovie: movie)
        show(detailsVC, sender: nil)
    }
}
