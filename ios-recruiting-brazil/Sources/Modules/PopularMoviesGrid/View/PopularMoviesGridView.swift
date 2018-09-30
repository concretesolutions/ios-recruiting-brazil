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
import SnapKit

final class PopularMoviesGridView: UIViewController {
    
    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    private var viewModel: PopularMoviesGridViewModelType
    private var numberOfItemsPerSection = 30
    
    // MARK: Lazy variables
    private lazy var collection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        let collection = UICollectionView(frame: self.view.frame,
                                          collectionViewLayout: layout)
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
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barTintColor = .lightYellow
        return searchBar
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
        self.setupBindSearchBar()
        self.viewModel.fetchMovies(search: nil)
    }
    
    private func setupBindCollection() {
        self.viewModel.movies.asObservable()
            .bind(to: collection.rx.items(cellIdentifier: "MovieCell",
                                          cellType: MovieCell.self)) { (_, movie: MovieModel, cell: MovieCell) in
                cell.configuration(viewModel: PopularMoviesCellViewModel(movie: movie))
            }.disposed(by: self.disposeBag)
        
        collection.rx.setDelegate(self).disposed(by: self.disposeBag)
    }
    
    private func setupBindLoading() {
        self.viewModel.showLoading.asObservable().subscribe(onNext: {[weak self] loading in
            loading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBindSearchBar() {
        self.searchBar.rx.text
            .debounce(1, scheduler: MainScheduler.instance)
//            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
               self?.viewModel.fetchMovies(search: text)
            }).disposed(by: disposeBag)
    }
}

extension PopularMoviesGridView: ViewConfiguration {
    func buildViewHierarchy() {
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.collection)
        self.view.addSubview(self.activity)
    }
    
    func setupConstraints() {
        self.searchBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide).offset(-1)
            make.height.equalTo(50)
        }
        
        self.collection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.searchBar.snp_bottomMargin).offset(7)
        }
    }
}

extension PopularMoviesGridView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 20.0) / 2.0
        return CGSize(width: width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height && self.viewModel.showLoading.value == false {
            numberOfItemsPerSection += 30
            self.viewModel.fetchMovies(search: self.searchBar.text)
        }
    }
}
