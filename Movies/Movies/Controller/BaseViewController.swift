//
//  BaseViewController.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, UISearchResultsUpdating {
    
    private let FAVORITED = "favorited_movies"
    
    private unowned var loading: UIActivityIndicatorView  { return (self.view as! BaseView).loading }
    private unowned var feedback:UILabel                  { return (self.view as! BaseView).feedbackMessage }
    
    /// The array to hold the filtered movies
    var filteredMovies:[Movie] = []
    
    var timer:Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.parent as? UITabBarController)?.hidesBottomBarWhenPushed = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadFavoriteList()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        saveFavoriteList()
    }
    
    /// Loads the favorite list (as json String) from the device
    private func loadFavoriteList(){
        let json = UserDefaults.standard.string(forKey: FAVORITED)
        User.current.favorites = Movie.convertJsonStringToFavoriteList(json)
    }
    
    /// Saves the favorite list in the device
    private func saveFavoriteList(){
        let json = Movie.convertFavoriteListToJsonString(User.current.favorites)
        UserDefaults.standard.setValue(json, forKeyPath: FAVORITED)
    }
    
    /// Hides or shows the loading
    func showLoading(_ show:Bool=true){
        if show{
            loading.startAnimating()
        }
        else{
            loading.stopAnimating()
        }
    }
    
    /// Shows a feedback message
    func showFeedback(message:String?=nil){
        feedback.text     = message
        feedback.isHidden = message != nil ? false:true
    }
    
    /// Adds the SearchController to the View
    func setSearchController(navBarTitle:String){
        self.title = navBarTitle
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a movie"
        definesPresentationContext = true
    
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        
        // Customize the searchbar to be white
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = .white
                
                // Rounded corner
                backgroundview.clipsToBounds = true
                backgroundview.layer.cornerRadius = 5
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
