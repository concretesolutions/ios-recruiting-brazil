//  Created Gustavo Garcia Leite on 03/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.

import UIKit


final class MoviesViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imgSearchEmptyState: UIImageView!
    
    @IBOutlet weak var lblSearchEmptyState: UILabel!
    
    var activityIndicatorView = UIActivityIndicatorView()
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    var presenter: MoviesPresenterProtocol?
}

//MARK: - Life cycles
extension MoviesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let presenter = presenter else { return }
        presenter.callSetupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movies"
        guard let presenter = presenter else { return }
        presenter.callCreateActivityIndicator()
        presenter.setAnimation(to: true)
        presenter.requestData()
    }
}


//MARK: - MoviesView
extension MoviesViewController: MoviesViewProtocol {
    func requestCollectionSetup() {
        guard let presenter = presenter else { return }
        presenter.setAnimation(to: false)
        presenter.setupView(with: collectionView, isSearchBarEmpty: isSearchBarEmpty)
    }
    
    func createActivityIndicator() {
        activityIndicatorView.frame = UIScreen.main.bounds
        self.view.addSubview(activityIndicatorView)
    }
    
    func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func changeIsAnimating(to animation: Bool) {
        if animation {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func reloadCollectionView() {
        guard let presenter = presenter else { return }
        presenter.setupView(with: collectionView, isSearchBarEmpty: isSearchBarEmpty)
    }
    
    func showResultImage(isHidden: Bool, text: String) {
        imgSearchEmptyState.isHidden = isHidden
        lblSearchEmptyState.isHidden = isHidden
        lblSearchEmptyState.text = "No resuls for '\(text)'"
    }
}

//MARK: - UISearchResultsUpdating
extension MoviesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let presenter = presenter, let text = searchController.searchBar.text else { return }
        presenter.filterMovies(using: text)
    }
}
