//
//  GridMoviesController.swift
//  ViperitTest
//
//  Created by Matheus Bispo on 7/25/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class MoviesGridController: UIViewController, StreamControllerProtocol {
    
    //MARK:- Dependencies -
    private var presenter: MoviesGridPresenterProtocol
    
    //MARK:- Variables -
    private var gridMoviesView = MoviesGridView()
    private var loadRow = 0
    private var lastLoadCell = 0
    private var disposeBag = DisposeBag()
    private var searchController = UISearchController(searchResultsController: nil)
    private var alert = UIAlertController(title: "Loading", message: "Wait for some seconds...", preferredStyle: .alert)
    private var loadingCount = 0
    private var isSearching = false
    
    private var movies = BehaviorSubject<[Movie]>(value: [])
    private var filteredMovies = BehaviorSubject<[Movie]>(value: [])
    
    //MARK:- Constructors -
    init(presenter: MoviesGridPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Override Methods -
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func loadView() {
        super.loadView()
        
        self.presenter.cacheGenres()
        
        self.view = gridMoviesView
        
        setupNavigationBar()
        
        // Setup Streams
        self.setupStreams()
        
        initialLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadMoviesFromCache()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setViewToInitialState()
    }
    
    //MARK:- Methods -
    
    /// Realiza um carregamento inicial
    fileprivate func initialLoad() {
        if loadingCount < 1 && !alert.isBeingPresented {
            self.present(alert, animated: true)
        }
        
        // Realiza o carregamento de 10 páginas
        for _ in 0...10 {
            presenter.loadNewPageMoviesFromNetwork()
            
            loadingCount += 1
        }
    }
    
    // Coloca a view em seu estado inicial
    fileprivate func setViewToInitialState() {
        self.gridMoviesView.searchBar.endEditing(true)
        self.gridMoviesView.searchBar.showsCancelButton = false
        self.gridMoviesView.searchBar.text = ""
        self.gridMoviesView.collectionView.setContentOffset(.zero, animated: false)
    }
    
    /// Configura a navigation bar
    fileprivate func setupNavigationBar() {
        self.navigationItem.title = "Movies"
    }
}

//MARK: - Configurações das Streams da CollectionView  -
extension MoviesGridController {
    func setupViewStreams() {
        gridMoviesView.collectionView.rx.didScroll.bind { [weak self] _ in
            self?.loadWhenScroll()
        }.disposed(by: disposeBag)
        
        gridMoviesView.collectionView.rx.itemSelected.bind { [weak self] (index) in
            if let cell = self?.gridMoviesView.collectionView.cellForItem(at: index) as? MoviesGridCell {
                self?.presenter.movieCellWasTapped(id: cell.id)
            }
        }.disposed(by: disposeBag)
        
        setupSearchBarStreams()
    }
    
    func loadWhenScroll() {
        self.loadRow += 1
        guard let currentCell = self.gridMoviesView.collectionView.visibleCells.last else {
            return
        }
        guard let index = self.gridMoviesView.collectionView.indexPath(for: currentCell)?.row else {
            return
        }
        
        if self.loadRow % 100 == 0 && index > self.lastLoadCell{
            self.presenter.loadNewPageMoviesFromNetwork()
            
            self.lastLoadCell = index
            self.loadRow = 0
        }
    }
}

//MARK: - Configurações das Streams do armazenamento local  -
extension MoviesGridController {
    func setupLocalStreams() {
        filteredMovies.bind(to: gridMoviesView.collectionView.rx.items(cellIdentifier: "MoviesGridCell")) {
            row, data, cell in
            
            let movieCell = cell as! MoviesGridCell
            movieCell.label.text = data.title
            movieCell.image.image = data.image
            movieCell.id = data.id
            movieCell.favorite.image = !data.liked ? UIImage(named: "favorite_gray_icon")! : UIImage(named: "favorite_full_icon")!
            
        }.disposed(by: disposeBag)
        
        movies.observeOn(MainScheduler.instance).bind { [weak self](movies) in
            self?.setFeedbackViewState(movies: movies)
            self?.filteredMovies.onNext(movies)
        }.disposed(by: disposeBag)
    }
    
    func setFeedbackViewState(movies: [Movie], error: Bool = false) {
        if error {
            self.gridMoviesView.feedbackView.show(type: .errorOccurred)
            
            return
        }
        
        if movies.isEmpty && !self.isSearching {
            self.gridMoviesView.feedbackView.show(type: .noMoviesAdded)
        } else if movies.isEmpty {
            self.gridMoviesView.feedbackView.show(type: .noMoviesFounded)
        } else {
            self.gridMoviesView.feedbackView.isHidden = true
        }
    }
}

//MARK: - Configurações das Streams do presenter  -
extension MoviesGridController {
    func setupPresenterStreams() {
        presenter.loadMoviesStream.subscribe(onNext: {
            [weak self] movies in
            self?.didEndPageLoad(movies: movies)
        }, onError: { [weak self] _ in
            self?.setFeedbackViewState(movies: [], error: true)
        }).disposed(by: disposeBag)
        
        presenter.reloadMoviesStream.subscribe(onNext: { [weak self] (movies) in
            self?.movies.onNext(movies)
        }, onError: { [weak self]  _ in
            self?.setFeedbackViewState(movies: [], error: true)
        }).disposed(by: disposeBag)
    }
    
    func didEndPageLoad(movies: [Movie]) {
        self.loadingCount -= 1
        
        if self.loadingCount < 2 {
            self.alert.dismiss(animated: true)
            self.movies.onNext(movies)
        }
    }
}

//MARK: - Configurações das Streams da search bar  -
extension MoviesGridController {
    func setupSearchBarStreams() {
        self.gridMoviesView.searchBar.rx.text.orEmpty.bind { [weak self] (searchString) in
            guard let movies = try? self?.movies.value() else {
                self?.gridMoviesView.feedbackView.show(type: .errorOccurred)
                return
            }
            
            self?.filteredMovies.onNext(movies.filter({ (movie) -> Bool in
                return movie.title.lowercased().contains(searchString.lowercased())
            }))
            
        }.disposed(by: disposeBag)
        
        self.gridMoviesView.searchBar.rx.textDidBeginEditing.bind { [weak self] (_) in
            self?.gridMoviesView.searchBar.showsCancelButton = true
            self?.isSearching = true
        }.disposed(by: disposeBag)
        
        self.gridMoviesView.searchBar.rx.cancelButtonClicked.bind { [weak self] (_) in
            self?.gridMoviesView.searchBar.endEditing(true)
            self?.gridMoviesView.searchBar.showsCancelButton = false
            self?.gridMoviesView.searchBar.text = ""
            self?.isSearching = false
            self?.presenter.loadMoviesFromCache()
        }.disposed(by: disposeBag)
        
        self.gridMoviesView.searchBar.rx.searchButtonClicked.bind { [weak self] (_) in
            self?.gridMoviesView.searchBar.endEditing(true)
            if let cancelButton = self?.gridMoviesView.searchBar.value(forKey: "cancelButton") as? UIButton {
                cancelButton.isEnabled = true
            }
        }.disposed(by: disposeBag)
        
        self.definesPresentationContext = true
    }
}
