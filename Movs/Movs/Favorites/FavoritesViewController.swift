//
//  FavoritesViewController.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesViewController: UIViewController {
    let tableView = UITableView()
    let disposeBag = DisposeBag()
    var coordinator: FavoritesCoordinator?

    override func loadView() {
        super.loadView()
        configureViews()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoritesViewController: ViewConfiguration {
    func setupViews() {
        view = tableView
        tableView.register(FavoriteMovieCell.self, forCellReuseIdentifier: FavoriteMovieCell.identifier)
        tableView.rowHeight = 150

        tableView.rx.setDelegate(self)
                    .disposed(by: disposeBag)
    }
}

extension FavoritesViewController: FavoritesViewModelInput {
    func remove() -> Observable<FavoriteMovieViewModel> {
        return tableView.rx.itemDeleted
                    .map(tableView.cellForRow)
                    .map {$0 as? FavoriteMovieCell }
                    .flatMap { $0?.viewModel.map(Observable.just) ?? Observable.empty() }
    }

    func loadTrigger() -> Observable<Void> {
        return rx.sentMessage(#selector(self.viewWillAppear))
            .map { _ in Void() }
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let action = UITableViewRowAction(style: .destructive, title: "Unfavorite") { _, indexPath in
            tableView.dataSource?.tableView!(tableView, commit: .delete, forRowAt: indexPath)
            return
        }

        return [action]
    }
}

extension FavoritesViewController: FavoritesViewModelOutput {
    func favorites(_ driver: Driver<[FavoriteMovieViewModel]>) {
        driver.drive(tableView.rx.items(cellIdentifier: FavoriteMovieCell.identifier,
                                             cellType: FavoriteMovieCell.self),
                     curriedArgument: setupCell)
            .disposed(by: disposeBag)

        setupItemSelection()
    }

    func setupItemSelection() {
        tableView.rx.itemSelected
            .map(tableView.cellForRow)
            .map { $0 as? FavoriteMovieCell }
            .flatMap { $0?.viewModel.map(Observable.just) ?? Observable.empty() }
            .subscribe(onNext: {[weak self] viewModel in
                guard let strongSelf = self else { return }
                strongSelf.coordinator?.next(on: strongSelf, with: viewModel)
            })
            .disposed(by: disposeBag)
    }

    func setupCell(idx: Int, viewModel: FavoriteMovieViewModel, cell: FavoriteMovieCell) {
        cell.setup(with: viewModel)
    }
}
