//
//  File.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 10/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class FavoritesView: UITableViewController {
    
    // MARK: - VIPER
    var presenter: FavoritesPresenter!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.dataSource = self.presenter
        
        // VIPER
        self.presenter.fetchFavoriteMovies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // VIPER
        self.presenter.reloadMovies()
        self.tableView.reloadData()
    }
    
    // FROM PRESENTER
    
    func showFavoriteMovies() {
        self.tableView.reloadData()
    }
    
    // FROM NAVIGATION
    
    func search(text: String) {
        self.presenter.searchMovie(containing: text)
    }
    
    func searchEnded() {
        self.presenter.searchMovieEnded()
    }
    
    func filter() {
        self.performSegue(withIdentifier: "filter", sender: "filter")
    }
    
    // INTERACTIONs METHODs
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        scrollViewInteractionStarted()
    }
    
    func scrollViewInteractionStarted() {
        // Recolhe teclado
        self.navigationItem.searchController?.searchBar.endEditing(true)
        // Interagindo sem texto de pesquisa = Recolhe pesquisa
        if let searchText = self.navigationItem.searchController?.searchBar.text {
            if searchText.isEmpty {
                self.navigationItem.searchController?.isActive = false
            }
        }
    }
    
    // TABLE VIEW
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.presenter.selectedMovie(at: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.presenter.hasFilter() && indexPath.row == 0 {
            return 50
        }else{
            return 131
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let switchFilter = sender as? String{
            if switchFilter == "filter" {
                if let filterSwitchView = segue.destination as? FilterView {
                    filterSwitchView.presenter = self.presenter
                }
            }
        }
    }
    
}


