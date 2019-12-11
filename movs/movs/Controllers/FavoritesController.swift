//
//  FavoritesController.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FavoritesController: UIViewController {
    // MARK: - Navigation item
    lazy var filterButton: UIBarButtonItem = {
        let item = UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector(goToFilters))
        return item
    }()
    
    // MARK: - Attributes
    lazy var screen = FavoritesScreen(delegate: self)
    let dataService = DataService.shared
    var collectionState: CollectionState = .loading //{
//        didSet {
//            switch self.collectionState {
//            case .loading:
//                DispatchQueue.main.async {
//                    self.screen.favoritesTableView.reloadData()
//                }
//            case .success:
//                DispatchQueue.main.async {
//                    self.screen.favoritesTableView.reloadData()
//                }
//            case .failure:
//                self.screen.showErrorView()
//            }
//        }
    //}
    
    // MARK: - View controller life cycle
    override func loadView() {
        super.loadView()
        self.title = "Favorites"
        self.view = self.screen
        self.navigationItem.rightBarButtonItem = self.filterButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
    }
    
    // MARK: - Navigation controller action
    @objc func goToFilters() {
        let controller = FiltersController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension FavoritesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMovieCell",
                                                 for: indexPath)
        return cell
    }
}

extension FavoritesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 176
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let movieDetailControler = MovieDetailController(
//        self.navigationController?.pushViewController(movieDetailControler,
//                                                      animated: true)
    }
}

extension FavoritesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
