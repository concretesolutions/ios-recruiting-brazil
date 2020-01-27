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
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.movie = DataManager().getMovies()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:UIResponder.keyboardWillHideNotification, object: nil)
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
        self.tableView.register(cell: FavoritesTableViewCell.self)
        self.tableView.emptyTitle = "Sua busca por \"x\" não resultou em nenhum resultado."
    }
    
    internal func setNavigation() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
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
        
        let movie = self.movie[indexPath.row]
        DataManager().delete(movie)
        self.movie.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
        tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
