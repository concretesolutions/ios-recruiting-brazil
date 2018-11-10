//
//  FavoritesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Public Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                coreDataService = CoreDataService(moc: moc)
            }
        }
    }
    
    // MARK: - Outlets
    @IBOutlet var errorHandlerView: UIView!
    @IBOutlet weak var errorImageView: UIImageView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    private var movies = [FavoriteMovies]()  // Core Data Model
    private var coreDataService : CoreDataService?
    
    private var search = UISearchController()
    private var searchInProgress = false
    private var searchArgument = String()
    private var noData = "You have no favorite movie."
    
    // View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Config
        uiConfig()

        // AppData
        loadAppData()
        
    }
 
    // MARK: - UI Config
    private func uiConfig() {
        self.navigationItem.hidesSearchBarWhenScrolling = false

        // Navigation Search
        search = UISearchController(searchResultsController: nil)
        search.searchBar.delegate = self
        search.searchResultsUpdater = self as? UISearchResultsUpdating
        search.searchBar.tintColor = UIColor.black
        
        // search text field background color
        if let textfield = search.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                
                // Background color
                backgroundview.backgroundColor = UIColor.white
                
                // Rounded corner
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        // associate to navigation item
        self.navigationItem.searchController = search

        
    }
    
    private func loadAppData() {
        self.movies = (self.coreDataService?.getAllFavorites())!
        print("☢️ reading favorites .... \(String(describing: self.movies.count))")
        if self.movies.count == 0 {
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: noData)
        }
    }
    
    
    
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        //        self.search.setEditing(true, animated: true)
        //        self.searchInProgress = true
        //        self.searchArgument = (searchBar.text?.trim())!
        //        //
        //        navigationController?.navigationBar.isHidden = true
        //        if #available(iOS 11.0, *) {
        //            navigationController?.navigationBar.prefersLargeTitles = false
        //        } else {
        //            // Fallback on earlier versions
        //        }
        //        self.search.isActive = false
        //        //
        //
        //        self.performSegue(withIdentifier: "showSearchScene", sender: self)
        //
        //    }
        
        //    @objc private func didSelectBarBackAction() {
        //
        //        // reinstantiate scene
        //        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //        let vc = storyboard.instantiateInitialViewController()
        //        UIApplication.shared.keyWindow?.rootViewController = vc
        //
        //
    }
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let fav = self.movies[indexPath.row]
        cell.movieTitle.text = fav.title
        cell.movieSubtitle.text = fav.overview
        cell.movieImage.image = UIImage()
        
        return cell
    }
    
    // MARK: - UI Actions
    @IBAction func filterAction(_ sender: Any) {
        if movies.count == 0 {
            view.alert(msg: noData, sender: self)
        }
        
        performSegue(withIdentifier: "showFilter", sender: self)
        
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilter" {
            let controller = segue.destination as! FilterController
            controller.movies = self.movies
        }
    }
    
}
