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
    
    var movies: [MovieEntity] = []
    
    var tableViewDataSource: FavoriteMovieTableViewDataSource?
    var tableViewDelegate: FavoriteMovieTableViewDelegate?
    
    //MARK: -INIT
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        favoriteTableView.delegate = self
//        favoriteTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreDataObjects()
        //favoriteTableView.reloadData()
        self.setupTableView(with: self.movies)
        configureViewComponents()
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if movies.count >= 1 {
                    favoriteTableView.isHidden = false
                } else {
                    favoriteTableView.isHidden = true
                }
            }
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
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.mainDarkBlue()
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
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

//MARK: - CoreData Remove
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
        
        self.fetchCoreDataObjects()
        tableViewDataSource?.movies.remove(at: indexPath.row)
    }
    
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
        
        do {
            movies = try managedContext.fetch(fetchRequest)
            print("Successfully fetched data.")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
}
