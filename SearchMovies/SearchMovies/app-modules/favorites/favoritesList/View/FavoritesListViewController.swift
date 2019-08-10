//
//  FavoritesListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class FavoritesListViewController: BaseViewController {
    //MARK: Properties
    var presenter:ViewToFavoritesListPresenterProtocol?
    private var favoritesList:[FavoritesDetailsData]!
    private var cellIdentifier:String = "cellItem"
    private var filteredData:[FavoritesDetailsData]!
    private var isFiltered:Bool = false
    private var filterDataList:[FilterSelectData]?
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var display: DisplayInformationView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightFilterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var filterButton: UIBarButtonItem!
    //MARK:Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesListRouter.setModule(self)
        self.searchBar.styleDefault()
        self.navigationController?.navigationBar.styleDefault()
        self.favoritesList = [FavoritesDetailsData]()
        self.filteredData = [FavoritesDetailsData]()
        self.hidePainelView(painelView: self.display, contentView: self.viewContent)
        self.tableView.register(UINib(nibName: "FavoritesTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: cellIdentifier)
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.heightFilterConstraint.constant = 0
        self.searchBar.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showActivityIndicator()
        self.presenter?.loadFavorites()
    }

 
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSelectSegue" {
            let navigation:UINavigationController = (segue.destination as! UINavigationController)
            let viewCtr:FilterSelectViewController = (navigation.viewControllers[0] as! FilterSelectViewController)
            
            if sender is [FilterSelectData] {
                viewCtr.listFilter = (sender as! [FilterSelectData])
            }
        }
    }
    
    //MARK: Actions
    @IBAction func didFilterButtonTap(_ sender: UIBarButtonItem) {
        
        self.presenter?.mapObjectFilter(favorites: self.favoritesList)
        self.presenter?.route?.pushToScreen(self, segue: "filterSelectSegue", param: self.filterDataList as AnyObject)
    }
    
    private func showResults(favorites: [FavoritesDetailsData]) {
        self.hideActivityIndicator()
        DispatchQueue.main.async {
            self.favoritesList = favorites
            
            self.hidePainelView(painelView: self.display, contentView: self.viewContent)
            
            if self.favoritesList.count == 0 {
                self.filterButton.isEnabled = false
                self.filterButton.image = nil
                self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Não há filmes adicionados em seu favoritos", typeReturn: .success)
                return
            }
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
}

extension FavoritesListViewController: PresenterToFavoritesListViewProtocol {
    func returnApplyFilter(favorites: [FavoritesDetailsData]) {
        self.showResults(favorites: favorites)
    }
    
    func returnFavorites(favorites: [FavoritesDetailsData]) {
        self.showResults(favorites: favorites)
    }
    
    func returnFavoritesError(message: String) {
         self.showPainelView(painelView: self.display, contentView: self.viewContent, description: message, typeReturn: .error)
    }
    
    func returnRemoveFavorites() {
        self.presenter?.loadFavorites()
    }
    
    func returnRemoveFavoritesError(message: String) {
        self.showPainelView(painelView: self.display, contentView: self.viewContent, description: message, typeReturn: .error)
    }
    
    func returnMapObjectFilter(filter: [FilterSelectData]) {
        self.filterDataList = filter
    }
}

extension FavoritesListViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.isFiltered ? self.filteredData.count : self.favoritesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FavoritesTableViewCell = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FavoritesTableViewCell)
        let favorite:FavoritesDetailsData = self.isFiltered ? self.filteredData[indexPath.row] : self.favoritesList[indexPath.row]
        
        cell.fill(name: favorite.name, descripton: favorite.overView, year: String(favorite.year), imageIconUrl: favorite.posterPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favorite:FavoritesDetailsData = self.isFiltered ? self.filteredData[indexPath.row] : self.favoritesList[indexPath.row]
        
        let deleteAction:UIContextualAction! = UIContextualAction(style: .normal, title: "Unfavorite") { (action, view, success) in
             self.presenter?.remove(favorite: favorite)
        }
        
        deleteAction.backgroundColor = UIColor.red
        
        let configuration:UISwipeActionsConfiguration! = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}

extension FavoritesListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            
            self.isFiltered = false
        }
        else {
            self.isFiltered = true
            self.filteredData = [FavoritesDetailsData]()
            for result in self.favoritesList {
                let nameRange:Range? = result.name.uppercased().range(of: searchText.uppercased())
                if  nameRange != nil{
                    self.filteredData.append(result)
                }
            }
        }
        self.hidePainelView(painelView: self.display, contentView: self.viewContent)
        
        
        self.tableView.reloadData()
        if self.filteredData.count == 0 && self.isFiltered {
            DispatchQueue.main.async {
                self.showPainelView(painelView: self.display, contentView: self.viewContent, description: "Sua busca por \(searchText) não resultou nenhum resultado", typeReturn: .success)
            }
        }
    }
}

extension FavoritesListViewController: FilterSelectViewControllerDelegate {
    func applyFilter(filters: [FilterReturn]) {
        
    }
}
