//
//  FavoritesController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class FavoritesController: UIViewController, UISearchBarDelegate,UISearchResultsUpdating , UITableViewDataSource, UITableViewDelegate, FilterProtocol {

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
    
    @IBOutlet var filterSelectionView: UIView!
    @IBOutlet weak var filterSelectionButton: UIButton!
    
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Properties
    
    private var movies = [FavoriteMovies]()  // Core Data Model
    private var coreDataService : CoreDataService?
    
    private var search = UISearchController(searchResultsController: nil)
    private var searchInProgress = false
    private var searchArgument = String()
    private var filterSelection = FilterSelection()
    
    private var selectedFavoriteMovie = FavoriteMovies()
    private var selectedImage = UIImage()
    
    private var modelAdapter = ModelAdapter()
    
    private var persistence = PersistenceManager()
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // observer manager
        observerManager()
        // UI Config
        uiConfig()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // inactivate search on movies controller to avoid black screen bug!!
        NotificationCenter.default.post(name: Notification.Name(rawValue: "willInactivateMoviesSearch"), object:self)
        
        // AppData
        loadAppData(filterSelection)
    }
 
    // MARK: - UI Config
    private func uiConfig() {
        self.navigationItem.hidesSearchBarWhenScrolling = false

        // Navigation Search
        search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self // as? UISearchResultsUpdating
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search favorites"
        search.searchBar.delegate = self
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
    
    private func loadAppData(_ filterSelection: FilterSelection) {
        // reset initial
        self.movies = [FavoriteMovies]()
    
        // get data
        self.movies = (self.coreDataService?.getAllFavorites(filterSelection: filterSelection))!
        
        if self.movies.count == 0 {
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: message(filterSelection))
        }else{
            view.hideErrorView(view: self.errorHandlerView)
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movies = [FavoriteMovies]()
        self.searchArgument = searchBar.text!.trimmingCharacters(in: .whitespaces)
        if self.searchArgument.isEmpty {
            return
        }
        filterSelection.searchArgument = self.searchArgument
        loadAppData(filterSelection)
        self.tableView.contentOffset = CGPoint.zero
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if !search.isActive {
            self.searchArgument = String()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterSelection = FilterSelection()
        tableView.tableHeaderView = nil
        loadAppData(filterSelection)
    }
    
    
    // MARK: - Table View Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        if self.movies.count > 0 {
        let fav = self.movies[indexPath.row]
    
        if fav.year!.isEmpty {
            cell.movieTitle.text = fav.title
        }else{
            cell.movieTitle.text = fav.title! + " (" + fav.year! + ")"
        }
    
        cell.movieSubtitle.text = fav.overview
        cell.movieImage.image = getImageFromDisk(id: fav.id ?? String())
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
        selectedFavoriteMovie = movies[indexPath.row]
        selectedImage = cell.movieImage.image!
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFavoriteDetail", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let movie = self.movies[indexPath.row]
            _ = self.persistence.deleteFile(movie.id!)
            self.coreDataService?.deleteFavorites(favoriteMovie: movie)
            self.movies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
        }
        loadAppData(filterSelection)
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    

    
    // MARK: - UI Actions
    @IBAction func filterAction(_ sender: Any) {
        if movies.count == 0 {
            view.alert(msg: message(filterSelection), sender: self)
        }
        tableView.tableHeaderView = nil
        self.tableView.contentOffset = CGPoint.zero
        filterSelection = FilterSelection()
        performSegue(withIdentifier: "showFilter", sender: self)
        
    }
    
    @IBAction func removeFilters(_ sender: Any) {
        filterSelection = FilterSelection()
        tableView.tableHeaderView = nil
        loadAppData(filterSelection)
        
    }
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFilter" { 
            let controller = segue.destination as! FilterController
            controller.delegate = self
            controller.movies = self.movies
            controller.moc = moc
            controller.hidesBottomBarWhenPushed = true
        
        }else if segue.identifier == "showFavoriteDetail" {
            let controller = segue.destination as! MovieDetailController
            controller.movie = self.modelAdapter.convertToBusiness(selectedFavoriteMovie)
            controller.movieImage = selectedImage
            controller.isFavorite = true
            controller.comesFromFavorite = true
            controller.moc = moc
        }
    }
    
    // MARK: - File System I/O
    private func getImageFromDisk(id: String) -> UIImage {
        let persistence = PersistenceManager()
        let imageData = persistence.getFile(id: id)
        return UIImage(data: imageData as Data) ?? UIImage()
    }
    
    // MARK: - Filter Protocol
    func didSelectFilter(filterSelection: FilterSelection) {
        print("*** YES, He have filters - filterSelection: \(filterSelection)")
        self.filterSelection = filterSelection
        self.filterSelectionView.backgroundColor = UIColor.applicationBarTintColor
        self.tableView.tableHeaderView = self.filterSelectionView
        movies = [FavoriteMovies]()
        self.loadAppData(filterSelection)
    }

    // MARK: - Observers
    private func observerManager() {
    
        removelAllObservers()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willInactivateFavoritesSearch(_:)),
                                               name: NSNotification.Name(rawValue: "willInactivateFavoritesSearch"),
                                               object: nil)
    }
 
    private func removelAllObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "willInactivateFavoritesSearch"), object: nil)
    }
    
    @objc private func willInactivateFavoritesSearch(_ sender: NSNotification) {
        self.search.isActive = false
    }
    
    // MARK: - Message Handler
    private func message(_ filterSelection: FilterSelection) -> String {
        var message = "You have no favorite movie"
        if !filterSelection.searchArgument.isEmpty {
            message = message + " with title: \(filterSelection.searchArgument)"
        }
        if !filterSelection.genre.isEmpty {
            message = message + ", genre: \(filterSelection.genre)"
        }
        if !filterSelection.year.isEmpty {
            message = message + ", year: \(filterSelection.year)"
        }

        return message
    }
    
}
