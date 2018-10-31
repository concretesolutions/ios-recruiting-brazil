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
        if !isSearchBarActive {
            // calculates where the user is in the y-axis
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height
            
            if offsetY > contentHeight - scrollView.frame.size.height {
                loadMoreData()
                tableView.reloadData()
            }
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
        moviesFiltered = movies.filter { (movie) -> Bool in
            return movie.title.contains(searchText)
        }
        
        if let _ = viewError { removeViewError() }

        // search didn't found anything and user is searching for something
        if moviesFiltered.count == 0 && !searchText.isEmpty {
            let request = ListMovies.Request(page: 0)
            interactor?.fetchPopularMovies(request: request)
        } else if searchText.isEmpty {
            hideSearchBar()
            tableView.reloadData()
        }
    }
    
    private func removeViewError(){
        if let _ = viewError {
            viewError?.removeFromSuperview()
            tableView.reloadData()
        }
    }
}
