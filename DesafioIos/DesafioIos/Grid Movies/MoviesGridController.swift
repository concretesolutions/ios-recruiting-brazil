//
//  MoviesController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
class MoviesGridController: UIViewController , SendDataApi {
    var moviesData:[Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.collectionViewController.movie = self.moviesData
                //self.collectionViewController.collectionView.reloadData()
            }
        }
    }
    let maneger = ManegerApiRequest()
    let collectionViewController = CollectionMoviesGridController(collectionViewLayout: UICollectionViewFlowLayout())
    let stateViewLoading = StatusView(state: .sending)
    let stateViewDontConnection = StatusView(state: .dontConnection)
    override func loadView() {
        self.view = UIView(frame: UIScreen.main.bounds)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
        self.navigationItem.title = "Movies"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.8823153377, green: 0.7413565516, blue: 0.3461299241, alpha: 1)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDataMovie()
        makeSearchController()
        setupCollectionViewController()
        setupViews()
    }
    func setupViews(){
        self.view.addSubview(stateViewDontConnection)
        self.view.addSubview(stateViewLoading)
    }
    func makeSearchController(){
        let searchController = UISearchController(nibName: nil, bundle: nil)
        self.navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
    }
    func setupDataMovie(){
        maneger.delegate = self
        maneger.sendMovies(numPage: 100)
    }
    // MARK: - Func to Get Movies From api
    func sendMovie(movies: [Movie]) {
        moviesData = movies
    }
    // MARK: - Func to Get Status From api
    func sendStatus(status: StatusConnection) {
        if status == .sending {
            DispatchQueue.main.async {
                self.collectionViewController.collectionView.isHidden = true
                self.stateViewDontConnection.isHidden = true
                self.stateViewLoading.isHidden = false
                self.stateViewLoading.state = status
            }
            
        }
        if status == .finish{
            DispatchQueue.main.async {
                self.collectionViewController.collectionView.isHidden = false
                self.stateViewLoading.isHidden = true
                self.stateViewDontConnection.isHidden = true
                self.view.bringSubviewToFront(self.collectionViewController.collectionView)
            }
        }
        if status == .dontConnection{
            DispatchQueue.main.async {
                self.collectionViewController.collectionView.isHidden = true
                self.stateViewLoading.isHidden = true
                self.stateViewDontConnection.isHidden = false
                self.stateViewDontConnection.state = .dontConnection
                print("erro da internet")
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        collectionViewController.collectionView.reloadData()
    }
    func setupCollectionViewController(){
        self.addChild(collectionViewController)
        collectionViewController.view.frame = UIScreen.main.bounds
        self.view.addSubview(collectionViewController.view)
    }
}
//MARK: - Protocols SearchBarController Updating
extension MoviesGridController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            self.collectionViewController.movie = self.moviesData
        } else {
            self.collectionViewController.movie = self.moviesData.filter({ (movie) -> Bool in
                return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            })
        }
        self.collectionViewController.collectionView.reloadData()
    }
}


