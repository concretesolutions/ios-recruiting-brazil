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

final class PopularMoviesGridController: UIViewController, StoryboardLoadable {
    static var storyboardName: String = "PopularMovies"

    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    private var viewModel: PopularMoviesGridViewModelType!
    private var numberOfItemsPerSection = 30
    
    // MARK: IBOutlet
    @IBOutlet private weak var collection: UICollectionView!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var lbError: UILabel!
    @IBOutlet private weak var vwError: UIView!
    
    func prepareForShow(viewModel: PopularMoviesGridViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindCollection()
        self.setupBindLoading()
        self.setupBindSearchBar()
        self.setupBindError()
        self.viewModel.fetchMovies(search: nil)
    }
    
    private func setupBindCollection() {
        self.viewModel.movies.asObservable()
            .bind(to: collection.rx.items(cellIdentifier: "MovieCell",
                                          cellType: MovieCell.self)) { (_, movie: MovieModel, cell: MovieCell) in
                cell.configuration(viewModel: PopularMoviesCellViewModel(movie: movie))
            }.disposed(by: self.disposeBag)
        
        collection.rx.setDelegate(self).disposed(by: self.disposeBag)
        
        collection.rx.modelSelected(MovieModel.self).subscribe(onNext: {[weak self] movie in
            let movieDetail = MovieDetailController.loadFromStoryboard()
            movieDetail.prepareForShow(viewModel: MovieDetailViewModel(movie: movie))
            self?.navigationController?.pushViewController(movieDetail, animated: true)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBindLoading() {
        self.viewModel.showLoading.asObservable().subscribe(onNext: {[weak self] loading in
            loading ? self?.activity.startAnimating() : self?.activity.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBindError() {
        self.viewModel.error.asObservable().subscribe(onNext: {[weak self] error in
            self?.lbError.text = error
            self?.vwError.isHidden = (error == nil)
            self?.collection.isHidden = !(error == nil)
        }).disposed(by: disposeBag)
    }
    
    private func setupBindSearchBar() {
        self.searchBar.rx.text
            .debounce(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
               self?.viewModel.fetchMovies(search: text)
            }).disposed(by: disposeBag)
    }
}

extension PopularMoviesGridController: UICollectionViewDelegateFlowLayout {
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
