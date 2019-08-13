//
//  MovieSearchViewController.swift
//  AppMovie
//
//  Created by ely.assumpcao.ndiaye on 04/07/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import UIKit

class MovieSearchViewController: UIViewController, MovieSelectionDelegate {
   
    //Mark: - Properties
    @IBOutlet weak var movieSearch: UISearchBar!
    @IBOutlet weak var movieCollection: UICollectionView!
    
    var movie = [Result]()
    //For system of search
    var filteredMovie = [Result]()
    var inSearchMode = false
    
    var isLoading = false
    var pageCount: Int = 1
    var totalPages: Int = 46
    
    var collectionViewDataSource: MovieSearchCollectionViewDataSource?
    var collectionViewDelegate: MovieSearchCollectionViewDelegate?
    
    //Mark: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        api()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toDetail"){
            let vc : MovieDetailViewController = segue.destination as! MovieDetailViewController
            vc.movieCell = sender as? Result
        }
    }
    
    func configureViewComponents(){
        //Navigation Controller
        self.navigationItem.title = "Movies"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.mainColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.mainColor()
        self.navigationController?.navigationBar.tintColor = UIColor.mainDarkBlue()
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.mainDarkBlue(), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)]
        //
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        //TODO: left bar button
        //        let rightButton : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "IconFilter"), style: .plain, target: self, action: #selector(self.actionFilter(sender:)))
        //        self.navigationItem.rightBarButtonItem = rightButton
        
        
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
    
    func setupCollectionView(with movies: [Result]){
        collectionViewDataSource = MovieSearchCollectionViewDataSource(movies: movies, collectionView: movieCollection)
        collectionViewDelegate = MovieSearchCollectionViewDelegate(movies: movies, delegate: self)
        
        movieCollection.dataSource = collectionViewDataSource
        movieCollection.delegate = collectionViewDelegate
        movieCollection.reloadData()
    }
    
    // MARK: - API
    func api(){
        MovieServices.instance.getMovies(page: pageCount){ movies in
            DispatchQueue.main.async {
                self.movie = movies
                self.setupCollectionView(with: movies)
                //self.movieCollection.reloadData()
            }
        }
    }
    
    func didSelect(movie: Result) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else {
            fatalError("should be a controller of type MovieDetailViewController")
        }
        
        controller.movieCell = movie
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
    func loadMovies(){
        print("LoadMovies")
        print(pageCount)
        MovieServices.instance.getMovies(page: pageCount){ movies in
            self.isLoading = false
            print(movies)
            DispatchQueue.main.async {
                self.movie += movies
                self.movieCollection.reloadData()
            }
        }
    }
    
}

// MARK: - UISearchDelate

extension MovieSearchViewController: UISearchBarDelegate{
    
}
