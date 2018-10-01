//
//  FavoriteMoviesView.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import UIKit
import RxSwift

final class FavoriteMoviesListController: UIViewController, StoryboardLoadable {
    
    static var storyboardName: String = "FavoriteMoviesList"
    
    private var viewModel: FavoriteMoveisListViewModelType!
    private let disposeBag = DisposeBag()
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    func prepareForShow(viewModel: FavoriteMoveisListViewModelType) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBindFavorites()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewModel.fetchFavorites()
        self.setupBindSearchBar()
        self.setupEditButtom()
    }
    
    private func setupEditButtom() {
        if tableView.isEditing {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Ok",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(endEdit))
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit",
                                                                     style: .plain,
                                                                     target: self,
                                                                     action: #selector(startEdit))
        }
    }
    
    private func setupBindFavorites() {
        self.viewModel.favorites.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "FavoriteCell",
                                          cellType: FavoriteCell.self)) { (_, movie: MovieModel, cell: FavoriteCell) in
                                            cell.configuration(viewModel: FavoriteCellViewModel(movie: movie))
            }.disposed(by: self.disposeBag)
        
        self.tableView.rx.modelSelected(MovieModel.self).subscribe(onNext: {[weak self] movie in
            let movieDetail = MovieDetailController.loadFromStoryboard()
            movieDetail.prepareForShow(viewModel: MovieDetailViewModel(movie: movie,
                                                                       service: MovieDetailService()))
            self?.navigationController?.pushViewController(movieDetail, animated: true)
        }).disposed(by: self.disposeBag)
        
        self.tableView.rx.itemDeleted.subscribe(onNext: {[weak self] indexPath in
            self?.viewModel.removeFavorite(index: indexPath.row)
        }).disposed(by: self.disposeBag)
    }
    
    private func setupBindSearchBar() {
        self.searchBar.rx.text
            .debounce(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
                self?.viewModel.filterFavorite(titleSearched: text ?? "")
            }).disposed(by: disposeBag)
    }
    
    @objc private func startEdit() {
        self.tableView.setEditing(true, animated: true)
        self.setupEditButtom()
    }
    
    @objc private func endEdit() {
        self.tableView.setEditing(false, animated: true)
        self.setupEditButtom()
    }
}
