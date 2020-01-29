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
    
    internal var movies = [Movie]()
    internal var filteredMovie = [Movie]()
    
    private var filterYear: String?
    private var filterGenre: Genre?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Localizable.movies
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: .filterIcon, style: .plain, target: self, action: #selector(self.filterAction))
        
        self.setTableView()
        self.setNavigation()
        
        self.navigationItem.largeTitleDisplayMode = .never
        self.definesPresentationContext = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.movies = DataManager.shared.getMovies()
            self.filteredMovie = self.movies
            self.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.clearFilter()
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
    }

}

extension FavoritesViewController {
    
    internal func reloadData() {
        UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
        }, completion: nil)
    }
    
    internal func setTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clear
        self.tableView.addFooterView()
        self.tableView.register(cell: FavoritesTableViewCell.self)
        
        self.tableView.emptyImage = UIImage.favoriteEmptyIcon
        self.tableView.emptyTitle = Localizable.noFavorites
    }
    
    internal func setNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    internal func filterMovies() {
        var result = self.movies
        if let genre = self.filterGenre {
            result = result.filter({ $0.genreIDS.contains(genre.id) })
        }
        if let year = self.filterYear {
            result = result.filter({ $0.releaseDate.contains(year) })
        }
        self.filteredMovie = result
        self.reloadData()
    }
    
    internal func clearFilter() {
        self.filterGenre = nil
        self.filterYear = nil
    }
    
    @objc internal func keyboardWillShow(notification: NSNotification) {
        if let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.height {
            var newContentInset: UIEdgeInsets = self.tableView.contentInset
            newContentInset.bottom = keyboardHeight + 20
            self.tableView.contentInset = newContentInset
        }
    }
    
    @objc internal func keyboardWillHide(notification: NSNotification) {
        self.tableView.contentInset = .zero
    }
    
    @objc internal func removeFilter() {
        self.clearFilter()
        self.filteredMovie = self.movies
        self.reloadData()
    }
    
    @objc private func filterAction() {
        let view = FilterViewController()
        view.filterHandler = { year, genre in
            self.filterYear = year
            self.filterGenre = genre
            self.filterMovies()
        }
        view.selectedYear = self.filterYear
        view.selectedGenre = self.filterGenre
        let nav = NavigationController(rootViewController: view)
        self.present(nav, animated: true, completion: nil)
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as! FavoritesTableViewCell
        
        let movie = self.filteredMovie[indexPath.row]
        cell.movie = movie
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        tableView.beginUpdates()
        
        let movie = self.filteredMovie[indexPath.row]
        DataManager.shared.delete(movie)
        self.filteredMovie.removeAll(where: { $0.id == movie.id })
        self.movies.removeAll(where: { $0.id == movie.id })
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .custom)
        button.setTitle(Localizable.removeFilter, for: .normal)
        button.setTitleColor(.primary, for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(self.removeFilter), for: .touchUpInside)
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (self.filterGenre != nil || self.filterYear != nil) ? 60 : 0
    }
    
}

extension FavoritesViewController: SearchBarDelegate {
    func completeItems() -> [Movie] {
        return self.movies
    }

    func filteredItems(items: [Movie]) {
        self.clearFilter()
        self.filteredMovie = items
        self.reloadData()
    }

    func filter(text: String, item: Movie) -> Bool {
        return item.title.lowercased().contains(text.lowercased())
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        self.tableView.emptyImage = UIImage.searchIcon
        self.tableView.emptyTitle = String(format: Localizable.searshText, text)
        
        if text.isEmpty {
            self.filteredItems(items: self.completeItems())
        }else{
            let items = self.completeItems().filter({ self.filter(text: text, item: $0) })
            self.filteredItems(items: items)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.tableView.emptyImage = UIImage.favoriteEmptyIcon
        self.tableView.emptyTitle = Localizable.noFavorites
        
        self.filteredItems(items: self.completeItems())
    }
}
