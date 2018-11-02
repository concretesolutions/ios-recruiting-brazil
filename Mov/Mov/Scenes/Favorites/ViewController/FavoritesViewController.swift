//
//  FavortiesViewController.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    private static let title = "Favorites"
    
    private(set) var viewModels = [FavoritesViewModel]()
    
    var interactor: FavoritesInteractor? {
        didSet {
            if let _ = self.interactor, self.viewModels.isEmpty {
                self.fetchFavorites()
            } else {/*do nothing*/}
        }
    }
    
    let stateMachine: ViewStateMachine = ViewStateMachine()
    
    var state: FavoritesState = .tableView {
        didSet {
            let state: ViewState
            
            switch self.state {
            case .tableView:
                state = self.tableViewState
            case .noResult(let request):
                self.noResultState.searchRequest = request
                state = self.noResultState
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
    
    lazy var favoritesView: FavoritesView = {
        return FavoritesView(frame: .zero)
    }()
    
    override func loadView() {
        self.view = BlankView()
        self.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchFavorites()
    }
    
    override func viewDidLoad() {
        self.setTabBarOptions()
        self.title = FavoritesViewController.title
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
    
    func displayNoResultsFound(for request: String) {
        self.state = .noResult(request)
    }
    
    func displayError() {
        // db error
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
            self.displayError()
            return
        }
        
        interactor.fetchFavorites()
    }
}


// MARK: State management
extension FavoritesViewController {
    enum FavoritesState {
        case tableView
        case noResult(String)
    }
}
