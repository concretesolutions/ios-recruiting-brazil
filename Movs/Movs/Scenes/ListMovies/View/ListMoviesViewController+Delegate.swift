//
//  FavoriteMoviesViewController+TableViewDelegate.swift
//  Movs
//
//  Created by Maisa on 30/10/18.
//  Copyright © 2018 Maisa Milena. All rights reserved.
//

import UIKit

// MARK: - Table view
extension ListMoviesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: detailMovieSegue, sender: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadMoreData()
            tableView.reloadData()
        }
    }
    
    private func loadMoreData() {
        if !fetchingMovies{
            page += 1
            fetchingMovies = true
            let request = ListMovies.Request(page: page)
            interactor?.fetchPopularMovies(request: request)
        }
    }
    
}

// MARK: - Search bar
/**
 This logic deals with:
 - Start searching for movies and presenting them while the user is typing;
 - If the result is not found locally, a proper Error View is presented indicating this message;
 - When the user types after and error, the Error Screen is cleaned and the search starts again;
 - The search bar disapears when selecting the "cancel button";
 */
extension ListMoviesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.endEditing(true)
        hideSearchBar()
        if let _ = viewError { removeViewError() }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Search for movies and put them into "moviesFiltered". This allows the Table View to access only the filted data. The user has the response of what is he searching for instantaneally.
        moviesFiltered = movies.filter { (movie) -> Bool in
            return movie.title.contains(searchText)
        }
        
        if let _ = viewError { removeViewError() }
        tableView.reloadSections(IndexSet.init(integer: 0), with: .automatic)
        
        // Search didn't found anything and search bar has content
        if moviesFiltered.count == 0 && !searchText.isEmpty {
            let request = ListMovies.Request(page: 0)
            interactor?.fetchPopularMovies(request: request)
        } else if searchText.isEmpty { // The user has cleaned the search bar
            hideSearchBar()
            tableView.reloadData()
        }
    }
    
    /// Remove the View Error (empty search, no connection) if there is one in the screen
    private func removeViewError(){
        if let _ = viewError {
            viewError?.removeFromSuperview()
            tableView.reloadData()
        }
    }
    
}
