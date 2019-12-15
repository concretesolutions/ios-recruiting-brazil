//
//  MoviesGridController.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesGridController: UIViewController {
    private let customView = MoviesGridView()
    let coreDataManager = CoreDataManager()
    var genres = [GenreDTO]()
    var pagesRequested = 1
    var searchName: String = ""
    var searchTimer: Timer?
    var searchedMovies = [MovieDTO]() {
        didSet {
            searchDataSource.searchedMovies = searchedMovies
            DispatchQueue.main.async {
                self.searchView.reloadData()
            }
        }
    }
    var fetchedMovies = [Movie]()
    let searchDataSource = SearchTableDataSource()
    lazy var searchView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.registerCell(cellType: MoviesTableViewCell.self)
        table.dataSource = searchDataSource
        table.delegate = self
        table.rowHeight = 150
        table.backgroundColor = .lightGray
        return table
    }()
    var movies = [MovieDTO]() {
        didSet {
            DispatchQueue.main.async {
                self.customView.grid.reloadData()
            }
        }
    }

    override func loadView() {
        self.view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        customView.grid.dataSource = self
        customView.grid.delegate = self
        setNavigation()
        requestMovies()
        requestGenres()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movies = coreDataManager.fetchMovies() {
            self.fetchedMovies = movies
        }
        customView.grid.reloadData()
    }

    private func setNavigation() {
        self.title = "Movies"
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .yellow
        self.navigationController?.navigationBar.backgroundColor = .yellow

        let search = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        search.searchResultsUpdater = self
        search.searchBar.placeholder = "Search"
        search.modalPresentationStyle = .fullScreen
        search.edgesForExtendedLayout = .all
        search.view = searchView
        self.navigationItem.searchController = search

    }

    func requestMovies(page: Int = 1) {
        let service = MovieService.getTrendingMovies(page)
        let session = URLSessionProvider()
        session.request(type: MoviesResultDTO.self, service: service) { (result) in
            switch result {
            case .success(let result):
                self.movies.append(contentsOf: result.movies)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func requestGenres() {
        let service = MovieService.getGenres
        let session = URLSessionProvider()
        session.request(type: GenresDTO.self, service: service) { (result) in
            switch result {
            case .success(let genres) :
                self.genres = genres.genres
            case .failure(let error):
                print(error)
            }
        }
    }
}
