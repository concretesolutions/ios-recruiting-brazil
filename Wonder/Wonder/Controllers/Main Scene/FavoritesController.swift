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
    
    private var selectedFavoriteMovie = FavoriteMovies()
    private var selectedImage = UIImage()
    
    private var modelAdapter = ModelAdapter()
    
    // View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UI Config
        uiConfig()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        if self.movies.count == 0 {
            view.showErrorView(errorHandlerView: self.errorHandlerView, errorType: .business, errorMessage: noData)
        }else{
            tableView.reloadData()
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
    
        if fav.year!.isEmpty {
            cell.movieTitle.text = fav.title
        }else{
            cell.movieTitle.text = fav.title! + " (" + fav.year! + ")"
        }
    
        cell.movieSubtitle.text = fav.overview
        cell.movieImage.image = getImageFromDisk(id: fav.id ?? String())
        
        
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
            self.coreDataService?.deleteFavorites(favoriteMovie: self.movies[indexPath.row])
            self.movies.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
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
    
    
}
