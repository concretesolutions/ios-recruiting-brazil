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
    }
}

extension FavoritesViewController: FavoritesViewModelInput {
    func triggers() -> Observable<Void> {
        return rx.sentMessage(#selector(self.viewDidAppear))
            .map { _ in Void() }
    }
}

extension FavoritesViewController: FavoritesViewModelOutput {
    func favorites(_ driver: Driver<[FavoriteMovieViewModel]>) {
        driver.drive(tableView.rx.items(cellIdentifier: FavoriteMovieCell.identifier,
                                             cellType: FavoriteMovieCell.self),
                     curriedArgument: setupCell)
            .disposed(by: disposeBag)

        tableView.rx.itemSelected
            .map {idx -> FavoriteMovieViewModel? in
                guard let cell = self.tableView.cellForRow(at: idx) as? FavoriteMovieCell else { return nil }

                return cell.viewModel
            }
            .subscribe(onNext: {[weak self] viewModel in
                guard let strongSelf = self else { return }
                strongSelf.coordinator?.next(on: strongSelf, with: viewModel!)
            })
            .disposed(by: disposeBag)
    }

    func setupCell(idx: Int, viewModel: FavoriteMovieViewModel, cell: FavoriteMovieCell) {
        cell.setup(with: viewModel)
    }
}
