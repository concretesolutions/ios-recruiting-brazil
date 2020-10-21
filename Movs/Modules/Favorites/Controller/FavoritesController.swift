//
//  FavoritesController.swift
//  Movs
//
//  Created by Joao Lucas on 08/10/20.
//

import UIKit
import RealmSwift

class FavoritesController: UITableViewController {
    
    private let realm = try! Realm()
    private var itemsFavorites = [FavoriteEntity]()
    
    private var searchBar: UISearchBar!
    private var filteredFavorites = [FavoriteEntity]()
    private var inSearchMode = false
    
    private var viewModel: FavoritesViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupViewModel()
        setupState()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTableView()
    }

    private func setupTableView() {
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
        tableView.register(FavoritesViewCell.self, forCellReuseIdentifier: "reuseListFavorites")
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        refresh()
    }
    
    private func refresh() {
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
        tableView.reloadData()
    }
    
    private func setupSearchBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showSearchBar))
                    
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "FilterIcon"), style: .plain, target: self, action: #selector(showFilterOption))
        
        navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    @objc func showFilterOption() {
        let controller = FilterOptionController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func btnRemoveFilter() {
        inSearchMode = false
        tableView.reloadData()
    }
}

extension FavoritesController: FilterOptionDelegate {
    func getItemsSelected(items: FilterOptionEntity) {
        if !items.genre.isEmpty {
            inSearchMode = true
            filteredFavorites = itemsFavorites.filter({ $0.genre.range(of: items.genre) != nil})
            tableView.reloadData()
        } else if !items.year.isEmpty {
            inSearchMode = true
            filteredFavorites = itemsFavorites.filter({ $0.year.range(of: items.year) != nil})
        } else {
            let empty = FavoritesEmptyView()
            tableView.backgroundView = empty
        }
    }
}

// - MARK: Setup search bar

extension FavoritesController: UISearchBarDelegate {
    @objc func showSearchBar() {
        configureSearchBar()
    }
        
    private func configureSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.tintColor = .black
                
        navigationItem.rightBarButtonItem = nil
        navigationItem.titleView = searchBar
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationItem.titleView = nil
        setupSearchBar()
        inSearchMode = false
        tableView.reloadData()
    }
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchBar.text == nil {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        } else {
            inSearchMode = true
            filteredFavorites = itemsFavorites.filter({ $0.title.range(of: searchText) != nil })
            tableView.reloadData()
        }
    }
}

extension FavoritesController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode {
            if self.filteredFavorites.isEmpty {
                let emptyView = EmptyView()
                tableView.backgroundView = emptyView
            } else {
                tableView.backgroundView = nil
            }
            return self.filteredFavorites.count
        }
        
        if itemsFavorites.isEmpty {
            let empty = FavoritesEmptyView()
            tableView.backgroundView = empty
        } else {
            tableView.backgroundView = nil
        }

        return itemsFavorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseListFavorites", for: indexPath) as! FavoritesViewCell
        
        let item = inSearchMode ? filteredFavorites[indexPath.row] : itemsFavorites[indexPath.row]
        
        cell.photo.downloadImage(from: (Constants.pathPhoto + item.photo))
        cell.title.text = item.title
        cell.overview.text = item.overview
        cell.year.text = item.year

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("Remove Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(btnRemoveFilter), for: .touchUpInside)
        button.heightAnchor(equalTo: 50)
        return button
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let item = inSearchMode ? filteredFavorites[index] : itemsFavorites[index]
        
        viewModel.fetchRemove(realm: realm, item: item, index: indexPath)
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        refresh()
    }
}

extension FavoritesController {
    
    func setupViewModel() {
        viewModel = FavoriteViewModelFactory().create()
    }
    
    func setupState() {
        viewModel.successRemove.observer(viewModel) { index in
            if !self.filteredFavorites.isEmpty {
                self.filteredFavorites.remove(at: index.row)
            } else {
                self.itemsFavorites.remove(at: index.row)
            }
        }
    }
}
