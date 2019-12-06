//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: - Variables
	var presenter: FavoritesPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnRemoveFilter: UIButton!
    @IBOutlet weak var btnRemoveFilterHeight: NSLayoutConstraint!
    var activityIndicatorView = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)

}

//MARK: - Life cycles
extension FavoritesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search Candies"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Favorites"
        guard let presenter = presenter else { return }
        presenter.getFavorites()
        presenter.setupTableView(with: tableView)
    }
}

//MARK: - FavoritesViewProtocol
extension FavoritesViewController: FavoritesViewProtocol {
    
}

//extension FavoritesViewController: UISearchResultsUpdating {
//  func updateSearchResults(for searchController: UISearchController) {
//    // TODO
//  }
//}
