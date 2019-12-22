//
//  FavoritesViewController.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import CoreData

struct Fav {
    let originalTitle, posterPath, releaseDate, overview: String
    let id: Int
}

class FavoritesViewController: UIViewController {
    
    let screen = FavoriteView()
    var tableData: [Fav] = []
    var filteredData: [Fav] = []
    let favoriteModel = FavoriteModel()
    let searchController = UISearchController(searchResultsController: nil)
    static var favTabDelegate: FavTabDelegate?
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        populateTableView()
        self.searchController.isActive = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorites"
        self.view.backgroundColor = UIColor(named: "whiteCustom")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "1dblackCustom")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "whiteCustom")!]
        
        self.navigationController?.navigationBar.isTranslucent = false
        //setting tableview
        screen.tableView.dataSource = self
        screen.tableView.delegate = self
        screen.tableView.rowHeight = 190
        screen.tableView.tableFooterView = UITableView()
        screen.tableView.separatorStyle = .none
        //setting searchbar
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search favorites"
        searchController.searchBar.searchTextField.tintColor = UIColor(named: "whiteCustom")
        searchController.searchBar.searchTextField.textColor = UIColor(named: "whiteCustom")
        searchController.delegate = self
        searchController.searchBar.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        screen.tableView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 90, right: 8)
    }
    
    private func populateTableView(){
        self.tableData.removeAll()
        self.screen.tableView.reloadData()
        self.favoriteModel.getAll{(results) in
            switch results{
                case .success(let results):
                    for result in results{
                        if result.value(forKey: "originalTitle") != nil{
                            let fav = Fav(originalTitle: result.value(forKey: "originalTitle") as! String, posterPath: result.value(forKey: "posterPath") as! String, releaseDate: result.value(forKey: "releaseDate") as! String, overview: result.value(forKey: "overview") as! String, id: result.value(forKey: "id") as! Int)
                            self.tableData.append(fav)
                            self.filteredData = self.tableData
                            self.screen.tableView.reloadData()
                            
                        }else{
                            self.tableData.removeAll()
                            self.screen.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }

}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.backgroundColor = .clear
        //ver aqui
        let currentData = self.filteredData[indexPath.item]
        guard let imageUrl = URL(string: "\(EndPoints.baseImageUrl.rawValue)\(currentData.posterPath)") else{return cell}
        cell.activityIndicatorToImage.startAnimating()
        DispatchQueue.main.async {
            cell.movieImageView.load(url:imageUrl){(e) in
               cell.activityIndicatorToImage.stopAnimating()
            }
        }
        cell.movieTitle.text = currentData.originalTitle
        cell.releaseDateLabel.text = currentData.releaseDate.replacingOccurrences(of: "-", with: "/")
        cell.overviewTextLabel.text = currentData.overview
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let unfavAction = UIContextualAction(style: .destructive, title: "Unfavorite") { (action, view, handler) in
            let dataID = self.filteredData[indexPath.item].id
            self.favoriteModel.delete(id: dataID){(r) in
                self.filteredData.remove(at: indexPath.item)
                self.screen.tableView.deleteRows(at: [indexPath], with: .automatic)
                self.populateTableView()
                self.view.makeToast("Unfavorited")
                FavoritesViewController.favTabDelegate?.unFavMovie(movId: dataID)
            }
            
        }
        unfavAction.backgroundColor = UIColor(named: "redCustom")
        let configuration = UISwipeActionsConfiguration(actions: [unfavAction])
        return configuration
    }
}

extension FavoritesViewController: UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {return}
        
        if searchBarText.isEmpty || searchBarText.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            filteredData = tableData
            self.screen.tableView.isHidden = false
            self.screen.noResultsImageView.isHidden = true
            self.screen.noResultsLabel.isHidden = true
        }else{
            filteredData = tableData.filter{(data)->Bool in
                self.screen.tableView.isHidden = false
                self.screen.noResultsImageView.isHidden = true
                self.screen.noResultsLabel.isHidden = true
                return data.originalTitle.range(of: searchBarText, options: [ .caseInsensitive ]) != nil
            }
            if filteredData.count == 0{
                self.screen.tableView.isHidden = true
                self.screen.noResultsImageView.isHidden = false
                self.screen.noResultsLabel.isHidden = false
                self.screen.noResultsLabel.text = "No results for \"\(searchBarText)\" "
            }
        }
        
        self.screen.tableView.reloadData()
        
    }
    
}
