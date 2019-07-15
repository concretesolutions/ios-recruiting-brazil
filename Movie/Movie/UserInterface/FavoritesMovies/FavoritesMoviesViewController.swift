//
//  FavoritesMoviesViewController.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesMoviesViewController: UIViewController {

    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var viewModel = FavoritesMoviesViewModel()
    
    var cellsViewModels: [FavoriteTableViewCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .white
        self.viewModel.delegate = self
        self.viewModel.fetchMovies()
        self.setupNavigationAndSearchBar()
        self.setupTableView()
    }
    
    fileprivate func setupNavigationAndSearchBar() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = ApplicationColors.yellow.uiColor
        
        self.searchBar.placeholder = "Search"
        self.searchBar.delegate = self
        self.searchBar.frame = CGRect(x: 0, y: 0, width: (navigationController?.view.bounds.size.width)!, height: 64)
        self.searchBar.barStyle = .blackTranslucent
        self.searchBar.barTintColor = ApplicationColors.yellow.uiColor
        
        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 44))
        accessoryView.backgroundColor = .black
        let doneButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 70))
        doneButton.setTitle("Done", for: .normal)
        doneButton.titleLabel?.textColor = ApplicationColors.yellow.uiColor
        doneButton.addTarget(self, action: #selector(self.closeKeyboard), for: .touchUpInside)
        accessoryView.addSubview(doneButton)
        doneButton.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(15)
        }
        
        self.searchBar.inputAccessoryView = accessoryView
        view.addSubview(self.searchBar)
        self.searchBar.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
        }
        
    }
    
    @objc func closeKeyboard() {
        self.view.endEditing(true)
    }
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = true
        
        self.tableView.separatorColor = .white
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.view.addSubview(self.tableView)
        
        self.tableView.register(FavoritesTableViewCell.self, forCellReuseIdentifier: "FavoritesTableViewCell")
        
        self.tableView.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(self.view)
            make.top.equalTo(self.searchBar.snp.bottom)
        }
        
    }

    
}

extension FavoritesMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesTableViewCell") as! FavoritesTableViewCell
        cell.viewModel = self.cellsViewModels[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            self.viewModel.removeFavorite(with: self.cellsViewModels[indexPath.row])
            self.cellsViewModels.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModel.getDetailsViewModel( cellViewModel: self.cellsViewModels[indexPath.row])
        let detailsView = MovieDetailsViewController()
        detailsView.viewModel = viewModel
        DispatchQueue.main.async {
            self.navigationController?.pushViewController(detailsView, animated: true)

        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
}


extension FavoritesMoviesViewController: FavoritesMoviesDelegate {
    func updateCellsViewModels(_ cellsViewModels: [FavoriteTableViewCellViewModel]) {
        self.cellsViewModels = cellsViewModels
        self.tableView.reloadData()
    }
    
}



extension FavoritesMoviesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filterBySearch(searchText)
    }
}
