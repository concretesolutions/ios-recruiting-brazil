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
    public var comesFromFavorite = false
    
    // MARK: - Private Propertie
    private var tableStructure = [String]()
    private var movieTableCellFactory = MovieTableCellFactory()
    
    // Core Data -----------------------------------
    private var coreDataService : CoreDataService?
    private var favoriteMoviesList = [FavoriteMovies]()
    // ---------------------------------------------
    
    private var persistence = PersistenceManager()
    
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        checkMovieImage()
        checkFavoriteExistence()
        uiConfig()
        loadTableStructure()
        observerManager()
    }
    
    // MARK: - Initial Procedures
    private func checkMovieImage() {
        if comesFromFavorite {
            movieImage = getImageFromDisk(id: String(movie.id))
        }
    }
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
        
        removelAllObservers()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didChangeFavorite(_:)),
                                               name: NSNotification.Name(rawValue: "didChangeFavorite"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectShare(_:)),
                                               name: NSNotification.Name(rawValue: "didSelectShare"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didSelectSegue(_:)),
                                               name: NSNotification.Name(rawValue: "didSelectSegue"),
                                               object: nil)
    }
    private func removelAllObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "didChangeFavorite"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "didSelectShare"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "didSelectSegue"), object: nil)
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
    @objc private func didSelectSegue(_ sender: NSNotification) {
        performSegue(withIdentifier: "showMoviePoster", sender: self)
    }
 
    // MARK: - Share Sheet Helper
    private func displayShareSheet(shareContent:String) {
        let activityViewController = UIActivityViewController(activityItems: [shareContent as NSString], applicationActivities: nil)
        present(activityViewController, animated: true, completion: {})
    }
    
    
    // MARK: - Core Data I/O
    private func addFavoriteMovie() {
        
        // disk persistence movie image
        addImageToDisk(id: String(movie.id))
        
        // call core data to add a favorite film
        self.coreDataService?.addFavorite(businessFavoriteMovies: getBusinessFavoriteMovies(), completion: { (success, favoriteMovies) in
            // completion
            if success {
                self.favoriteMoviesList = favoriteMovies
            }else{
                // Core Data Error
                print("A problem occured - Core Data - 03X")
            }
        })
    }
    
    private func deleteFavorite() {
        
        // disk persistence movie image
        deleteImageFromDisk(id: String(movie.id))

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
    
    
    // MARK: - File System I/O
    private func addImageToDisk(id: String) {
        let imageData = movieImage.pngData()
        _ = persistence.addFile(id: id, data: imageData! as NSData)
        
    }
    
    private func getImageFromDisk(id: String) -> UIImage {
        let imageData = persistence.getFile(id: id)
        return UIImage(data: imageData as Data) ?? UIImage()
    }
    
    private func deleteImageFromDisk(id: String) {
        _ = persistence.deleteFile(id)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMoviePoster" {
            let webService = WebService()
            let controller = segue.destination as! PosterController
            controller.urlParam = webService.getFullMoviePosterUrl(movie.poster_path)
        }
    }
    
    
}
