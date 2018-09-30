//
//  PopularMoviesGridView.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class PopularMoviesGridView: UIViewController {
    
    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    private var viewModel: PopularMoviesGridViewModelType
    private var numberOfItemsPerSection = 30
    
    // MARK: Lazy variable
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        collection.backgroundColor = UIColor.white
        return collection
    }()
    
    private lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.center = self.view.center
        activity.hidesWhenStopped = true
        return activity
    }()
    
    init(viewModel: PopularMoviesGridViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewConfiguration()
        self.setupBindCollection()
        self.setupBindLoading()
        self.viewModel.fetchMovies()
    }
    
    private func setupBindCollection() {
        self.viewModel.movies.asObservable()
            .bind(to: collection.rx.items(cellIdentifier: "MovieCell",
                                          cellType: MovieCell.self)) { (_, movie: MovieModel, cell: MovieCell) in
                                            cell.configuration(movie: movie)
            }.disposed(by: self.disposeBag)
        
        collection.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    
    private func setupBindLoading() {
        self.viewModel.showLoading.asObservable().subscribe(onNext: {[weak self] loading in
            loading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
}

extension PopularMoviesGridView: ViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(self.collection)
        self.view.addSubview(self.activity)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.collection.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collection.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collection.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PopularMoviesGridView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 2.0
        return CGSize(width: width, height: 130)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height && self.viewModel.showLoading.value == false {
            numberOfItemsPerSection += 30
            self.viewModel.fetchMovies()
        }
    }
}
