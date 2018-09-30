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
    }
    
    private func setupBindFavorites() {
        self.viewModel.favorites.asObservable()
            .bind(to: self.tableView.rx.items(cellIdentifier: "FavoriteCell",
                                          cellType: FavoriteCell.self)) { (_, movie: MovieModel, cell: FavoriteCell) in
                                            cell.configuration(viewModel: FavoriteCellViewModel(movie: movie))
            }.disposed(by: self.disposeBag)
    }
    
    private func setupBindSearchBar() {
        self.searchBar.rx.text
            .debounce(1, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] text in
                self?.viewModel.filterFAvorite(titleSearched: text ?? "")
            }).disposed(by: disposeBag)
    }
}
