//
//  MovieDetailController.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit
import CoreData

class MovieDetailController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Public Properties
    public var moc : NSManagedObjectContext? {
        didSet {
            if let moc = moc {
                coreDataService = CoreDataService(moc: moc)
            }
        }
    }
    
    public var movie = Results()
    public var movieImage = UIImage()
    public var isFavorite = false
    
    // MARK: - Private Propertie
    private var tableStructure = [String]()
    private var movieTableCellFactory = MovieTableCellFactory()
    
    // Core Data -----------------------------------
    private var coreDataService : CoreDataService?
    private var favoriteMoviesList = [FavoriteMovies]()
    // ---------------------------------------------
    
    
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkFavoriteExistence()
        uiConfig()
        loadTableStructure()
        observerManager()
    }
    
    // MARK: - Favorite Integrity
    private func checkFavoriteExistence() {
        if !isFavorite {
            isFavorite = self.coreDataService?.favoriteExists(id: String(movie.id)) ?? false
        }
    }
    
    // MARK: - UI Config
    private func uiConfig() {
        // Visual Effects
        tableView.backgroundView = view.blur(image: movieImage)
    }
    
    private func loadTableStructure() {
        tableStructure.append("DetailImageCell")
        tableStructure.append("DetailTitleCell")
        tableStructure.append("DetailInfoCell")
        tableStructure.append("DetailDescriptionCell")
        tableStructure.append("DetailSeparatorCell")
        tableStructure.append("DetailActionCell")
    }
    
    // MARK: - Table View Data Source & Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableStructure.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        checkFavoriteExistence()
        
        let cell = self.movieTableCellFactory.movieTableCell(movie: movie, indexPath: indexPath, movieImage: movieImage, isFavorite: isFavorite,  tableView: tableView)
        return cell
    }
    
    
    // MARK: - UI Actions
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Status Bar Helper
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Observers
    private func observerManager() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeFavorite(_:)),
                                               name: NSNotification.Name(rawValue: "didChangeFavorite"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectShare(_:)),
                                               name: NSNotification.Name(rawValue: "didSelectShare"),
                                               object: nil)
    }
    
    // observer actions
    @objc private func didChangeFavorite(_ sender: NSNotification) {
        
        if isFavorite {
            // remove favorite
            self.deleteFavorite()
        }else{
            // add favorite
            self.addFavoriteMovie()
        }
        isFavorite = !isFavorite
        // reload table view to refresh fav icon
        tableView.reloadData()
        
    }
    @objc private func didSelectShare(_ sender: NSNotification) {
        let webService = WebService()
        displayShareSheet(shareContent: movie.title + " - " + webService.getFullUrl(movie.poster_path))
    }
 
    // MARK: - Share Sheet Helper
    private func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    
    // MARK: - Core Data I/O
    private func addFavoriteMovie() {

        // call core data to add a favorite film
        self.coreDataService?.addFavorite(businessFavoriteMovies: getBusinessFavoriteMovies(), completion: { (success, favoriteMovies) in
            // completion
            if success {
                self.favoriteMoviesList = favoriteMovies
                print("** inside after core data insert")
                for favorite in self.favoriteMoviesList {
                    print("*** fav: \(favorite)")
                }
                
            }else{
                // Core Data Error
                print("A problem occured while tryin to save favorite movies to core data!")
            }
        })
    }
    
    private func deleteFavorite() {
        
//        self.coreDataService = CoreDataService(moc: moc!)
//        let favs = self.coreDataService?.getAllFavorites()
//        for item in favs! {
//            print("         +++++++ id: \(item.id)  +++++++ title: \(item.title)")
//        }
//
//
//
        let fav = self.coreDataService?.getFavorite(id: String(movie.id))
        self.coreDataService?.deleteFavorites(favoriteMovie: fav!)
    }
    
    private func getBusinessFavoriteMovies() -> BusinessFavoriteMovies {
        
        let index = movie.release_date.index(movie.release_date.startIndex, offsetBy: 4)
        let year = String(movie.release_date[..<index])
        
        let genreString = AppSettings.standard.genreForDatabase(genreIdArray: movie.genre_ids)
        
        let businessFavoriteMovies = BusinessFavoriteMovies()
        businessFavoriteMovies.year = year
        businessFavoriteMovies.overview = movie.overview
        businessFavoriteMovies.genre = genreString
        businessFavoriteMovies.title = movie.title
        businessFavoriteMovies.id = String(movie.id)
        businessFavoriteMovies.poster = movie.poster_path
        
        return businessFavoriteMovies
        
    }
    
    
}
