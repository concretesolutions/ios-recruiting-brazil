//
//  MoviesGridViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit

class MoviesGridViewController: UIViewController {
    
    //CollectionView
    let collectionView = MoviesGridCollectionView()
    var collectionViewDataSource: MoviesGridCollectionDataSource?
    var collectionViewDelegate: MoviesGridCollectionDelegate?
    //Auxiliar Views
    var activityIndicator = ActivityIndicator(frame: .zero)
    var errorView = ErrorView(frame: .zero)
    //TMDB API
    let tmdb = TMDBManager()
    //Properties
    var movies:[Movie] = []
    
    fileprivate enum LoadingState{
        case loading
        case ready
    }
    
    fileprivate enum PresentationState{
        case loadingContent
        case displayingContent
        case error
    }
    
    fileprivate var loadingState: LoadingState = .ready {
        didSet{
            DispatchQueue.main.async {
                self.refreshLoading(state: self.loadingState)
            }
        }
    }
    
    fileprivate var presentationState: PresentationState = .loadingContent{
        didSet{
            DispatchQueue.main.async {
                self.refreshUI(for: self.presentationState)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loadingState = .loading
        presentationState = .loadingContent
        tmdb.getPopularMovies(page: 1) { (result) in
            self.loadingState = .ready
            switch result{
            case .success(let movies):
                self.handleFetchOf(movies: movies)
            case .error:
                self.presentationState = .error
            }
        }
    }
    
    func handleFetchOf(movies:[Movie]){
        self.setupCollectionView(with: movies)
        self.presentationState = .displayingContent
    }
    
    
    func setupCollectionView(with movies: [Movie]){
        self.collectionView.isHidden = false
        collectionViewDataSource = MoviesGridCollectionDataSource(movies: movies, collectionView: self.collectionView)
        self.collectionView.dataSource = collectionViewDataSource
        collectionViewDelegate = MoviesGridCollectionDelegate(movies: movies, delegate: self)
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.reloadData()
    }
    
}

//MARK:- CodeView protocol
extension MoviesGridViewController: CodeView{
    
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
        view.addSubview(errorView)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        errorView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

//MARK:- Handling with UI changings

extension MoviesGridViewController{
    
    fileprivate func refreshLoading(state: LoadingState){
        switch state{
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
                self.activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func refreshUI(for presentationState: PresentationState){
        switch presentationState{
        case .loadingContent:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
            errorView.isHidden = true
        case .displayingContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
            errorView.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
            errorView.isHidden = false
        }
    }
}

extension MoviesGridViewController: MoviesSelectionDelegate{
    func didSelectMovie(movie: Movie) {
        let movieDetailController = MovieDetailTableViewController(movie: movie, style: .grouped)
        movieDetailController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(movieDetailController, animated: true)
    }
}
