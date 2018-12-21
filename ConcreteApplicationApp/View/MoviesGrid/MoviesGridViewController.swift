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
    var activityIndicator = ActivityIndicator(frame: .zero)
    //TMDB API
    let tmdb = TMDBManager()
    //Properties
    var movies:[Movie] = []
    
    //FIXME:- learn about fileprivate
    
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
            refreshLoading(state: loadingState)
        }
    }
    
    fileprivate var presentationState: PresentationState = .loadingContent{
        didSet{
            refreshUI(for: presentationState)
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
                print("error")
                //FIXME:- display error
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
        collectionViewDelegate = MoviesGridCollectionDelegate(movies: movies)
        self.collectionView.delegate = collectionViewDelegate
        self.collectionView.reloadData()
    }
    
}

//MARK:- CodeView protocol
extension MoviesGridViewController: CodeView{
    
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
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
    }
}

//MARK:- handling with UI changings

extension MoviesGridViewController{
    
    fileprivate func refreshLoading(state: LoadingState){
        switch state{
        case .loading:
            activityIndicator.startAnimating()
            print("start activity Indicator")
        case .ready:
            activityIndicator.stopAnimating()
            print("stop activity Indicator")
        }
    }
    
    fileprivate func refreshUI(for presentationState: PresentationState){
        switch presentationState{
        case .loadingContent:
            print("display loading state")
            collectionView.isHidden = true
            activityIndicator.isHidden = false
        case .displayingContent:
            print("display content")
        case .error:
            print("error state")
        }
    }
    
}
