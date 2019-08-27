//
//  FavoriteMovieViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 05/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class FavoriteMovieViewController: UIViewController {
    
    //MARK: - PROPERTIES
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var movies: [MovieEntity] = []
    var inSearchMode = false
    var filteredMovieFromEntity = [MovieEntity]()
    
    var tableViewDataSource: FavoriteMovieTableViewDataSource?
    var tableViewDelegate: FavoriteMovieTableViewDelegate?
    
    //MARK: -INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchCoreDataObjects()
        self.setupTableView(with: self.movies)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureViewComponents()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        favoriteTableView.isHidden = true
    }
    
    //MARK - CALL FETCH BY COREDATA
    func fetchCoreDataObjects() {
        let manegerCoreData = ManegerCoreData()
        manegerCoreData.fetch(MovieEntity.self, successCompletion: { (movieEntity) in
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.movies = movieEntity
            if self.movies.count >= 1 {
                self.favoriteTableView.isHidden = false
            } else {
                self.favoriteTableView.isHidden = true
            }
            
        }) { (error) in
            print("Could't load favorite movies.")
            self.favoriteTableView.isHidden = true
        }
    }

    //MARK - SETUP TABLEVIEW
    func setupTableView(with movie: [MovieEntity]) {
        tableViewDataSource = FavoriteMovieTableViewDataSource(movies: movie, tableView: favoriteTableView)
        tableViewDelegate = FavoriteMovieTableViewDelegate(movies: movie, delegate: self)
        
        favoriteTableView.dataSource = tableViewDataSource
        favoriteTableView.delegate = tableViewDelegate
        favoriteTableView.reloadData()
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Favoritos"
        self.tabBarController?.tabBar.isHidden = false
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //Search
        movieSearch.barTintColor = UIColor.mainColor()
        movieSearch.tintColor = UIColor.mainOrange()
        movieSearch.showsCancelButton = false
        for v:UIView in movieSearch.subviews.first!.subviews {
            if v.isKind(of: UITextField.classForCoder()) {
                (v as! UITextField).tintColor = UIColor.white
                (v as! UITextField).backgroundColor = UIColor.mainOrange()
            }
        }
    }
    
    @IBAction func moviesBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
}

//MARK: - CoreData PROTOCOLO SELECTION DELEGATE REMOVE AND CLICK DETAILS
extension FavoriteMovieViewController: MovieSelectionDelegate{
    
    func didSelect(movie: Result) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("should be a controller of type MovieDetailViewController")
        }
        
        controller.movieCell = movie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func removeMovie(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(movies[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully removed goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
        tableViewDataSource?.movies.remove(at: indexPath.row)
        self.fetchCoreDataObjects()
        
    }
    
}

extension FavoriteMovieViewController: UISearchBarDelegate{
    func setupSearchBar() {
        self.movieSearch.delegate = self
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.text = ""
        movieSearch.showsCancelButton = false
        print("Cancel")
        self.setupTableView(with: self.movies)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            inSearchMode = false
            self.setupTableView(with: self.movies)
        } else {
            movieSearch.showsCancelButton = true
            inSearchMode = true
            print(searchText)
            filteredMovieFromEntity = movies.filter({ $0.movieTitle?.lowercased().range(of: searchText.lowercased()) != nil })
            //filter({$0.title.lowercased().contains(searchText.lowercased())})
            print(filteredMovieFromEntity)
            if verifyisContainsTheMovie(){
                EmptyTextField(text: "Not Found", message: "Filme não encontrado na lista de favoritos")
                self.setupTableView(with: self.movies)
                return
            }
            self.setupTableView(with: self.filteredMovieFromEntity)
        }
    }
    
    func verifyisContainsTheMovie() -> Bool {
        return filteredMovieFromEntity.isEmpty
    }
    
    
}

