//
//  PopularMoviesViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 16/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit

class PopularMoviesViewController: UIViewController {

    //MARK: - Interface
    lazy var activityIndicator:UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.color = Style.colors.secondaryYellow
        activityIndicator.contentMode = .scaleAspectFit
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    //MARK: - Properties
    let tmdbService = TMDBService()
    let collectionView = PopularMoviesCollectionView()
    var collectionViewDatasource: PopularMoviesCollectionViewDataSource?
    var collectionViewDelegate: PopularMoviesCollectionViewDelegate?
    
    //MARK: - UI States Control
    fileprivate enum LoadingState {
        case loading
        case ready
    }
    
    fileprivate enum PresentationState {
        case initial
        case showContent
        case error
    }
    
    fileprivate var loadingState: LoadingState = .loading {
        didSet {
            updateLoading(state: loadingState)
        }
    }
    
    fileprivate var presentationState: PresentationState = .initial {
        didSet {
            DispatchQueue.main.async {
                self.updatePresentation(state: self.presentationState)
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getPopularMovies(page: 1)
    }
    
    //MARK: - Setup
    func setupCollectionView(with movies: [Movie]) {
        collectionViewDatasource = PopularMoviesCollectionViewDataSource(movies: movies, collectionView: collectionView)
        collectionView.dataSource = collectionViewDatasource
        
        collectionViewDelegate = PopularMoviesCollectionViewDelegate(movies: movies, delegate: self)
        collectionView.delegate = collectionViewDelegate
        
        collectionView.reloadData()
    }
    
    //MARK: TMDB Service
    func getPopularMovies(page: Int) {
        loadingState = .loading
        presentationState = .initial
        tmdbService.getPopularMovies(page: page) { (result) in
            switch result {
            case .success(let movies):
                self.setupCollectionView(with: movies)
                self.loadingState = .ready
                self.presentationState = .showContent
            case .error(let anError):
                print("Error: \(anError)")
                self.presentationState = .error
            }
        }
    }
    
    //MARK: UI States
    fileprivate func updateLoading(state: LoadingState) {
        switch state {
        case .loading:
            activityIndicator.startAnimating()
        case .ready:
            activityIndicator.stopAnimating()
        }
    }
    
    fileprivate func updatePresentation(state: PresentationState) {
        switch state {
        case .initial:
            collectionView.isHidden = true
            activityIndicator.isHidden = false
        case .showContent:
            collectionView.isHidden = false
            activityIndicator.isHidden = true
        case .error:
            collectionView.isHidden = true
            activityIndicator.isHidden = true
        }
    }
    
}

extension PopularMoviesViewController: MovieSelectionDelegate {
    func didSelect(movie: Movie) {
//        let movieVC = MovieViewController(movie: movie)
        let movieVC = MovieTableViewController(movie: movie)
        navigationController?.pushViewController(movieVC, animated: true)
    }
}

extension PopularMoviesViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
