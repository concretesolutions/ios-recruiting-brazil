//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

//MARK: View -
protocol FavoritesViewProtocol: class {

    var presenter: FavoritesPresenterProtocol?  { get set }

    /* Presenter -> ViewController */
}

//MARK: Presenter -
protocol FavoritesPresenterProtocol: class {

    var interactor: FavoritesInteractorInputProtocol? { get set }
    var movies: [Movie]? { get set }
    var tableViewDataSource: FavoritesTableViewDataSource? { get set }
    func getFavorites()
    func setupTableView(with tableView: UITableView)
}

final class FavoritesPresenter: FavoritesPresenterProtocol {

    weak private var view: FavoritesViewProtocol?
    var interactor: FavoritesInteractorInputProtocol?
    private let router: FavoritesRouterProtocol
    var tableViewDataSource: FavoritesTableViewDataSource?
    
    var movies: [Movie]?

    init(interface: FavoritesViewProtocol, interactor: FavoritesInteractorInputProtocol?, router: FavoritesRouterProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
    
    func getFavorites() {
        guard let interactor = interactor else { return }
        interactor.requestMovies()
    }
    
    func setupTableView(with tableView: UITableView) {
        guard let movies = movies else { return }
        tableViewDataSource = FavoritesTableViewDataSource(using: movies, with: tableView)
    }

}

extension FavoritesPresenter: FavoritesInteractorOutputProtocol {
    func sendMovies(movies: [Movie]) {
        self.movies = movies
    }
}
