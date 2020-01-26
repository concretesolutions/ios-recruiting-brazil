//
//  FavoritesViewController.swift
//  movs
//
//  Created by Isaac Douglas on 21/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {

    @IBOutlet weak var tableView: TableView!
    
    internal var movie = [Movie]() {
        willSet {
            self.filteredMovie = newValue
        }
    }
    
    internal var filteredMovie = [Movie]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(self.filterAction))
        
        self.setTableView()
        self.setNavigation()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.definesPresentationContext = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.movie = DataManager().getMovies()
        }
    }
    
    @objc private func filterAction() {
        let view = FilterViewController()
        let nav = NavigationController(rootViewController: view)
        self.present(nav, animated: true, completion: nil)
    }

}

extension FavoritesViewController {
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: UITableViewCell.self)
        self.tableView.emptyTitle = "Sua busca por \"x\" não resultou em nenhum resultado."
    }
    
    internal func setNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: UITableViewCell.identifier)
        
        let movie = self.filteredMovie[indexPath.row]
        cell.selectionStyle = .none
        cell.textLabel?.text = movie.title
        cell.detailTextLabel?.text = movie.releaseDate
        cell.detailTextLabel?.textColor = .primary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = self.filteredMovie[indexPath.row]
        DataManager().delete(movie)
        tableView.reloadData()
    }
    
}

extension FavoritesViewController: SearchBarDelegate {
    func completeItems() -> [Movie] {
        return self.movie
    }

    func filteredItems(items: [Movie]) {
        self.filteredMovie = items
    }

    func filter(text: String, item: Movie) -> Bool {
        return item.title.lowercased().contains(text.lowercased())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if text.isEmpty {
            self.filteredItems(items: self.completeItems())
        }else{
            let items = self.completeItems().filter({ self.filter(text: text, item: $0) })
            self.filteredItems(items: items)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.filteredItems(items: self.completeItems())
    }
}
