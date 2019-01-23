//
//  ViewController.swift
//  Movs
//
//  Created by Filipe Jordão on 22/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PopularMoviesViewController: UIViewController {
    private let collectionView = UICollectionView()
    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        view = collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PopularMoviesViewController: MoviesViewModelActuator, MoviesDisplayer {
    func didAppearBind() -> Observable<Void> {
        return rx.sentMessage(#selector(viewDidAppear)).map { _ in Void() }
    }

    func trigger() -> Driver<Void> {

        return collectionView.isNearBottom()
                             .filter { $0 == true }
                             .map { _ in Void() }
                             .asDriver(onErrorJustReturn: Void())
    }

    func display(error: Driver<Void>) {

    }

    func display(movies: Driver<[MovieViewModel]>) {
        movies.drive(collectionView.rx.items(cellIdentifier: "",
                                             cellType: UICollectionViewCell.self)) { _, movie, cell in

        }
        .disposed(by: disposeBag)
    }
}

