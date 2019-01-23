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
    private lazy var collectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
    }()

    private let disposeBag = DisposeBag()

    override func loadView() {
        super.loadView()
        view = collectionView
        view.backgroundColor = .white
        collectionView.register(PopularMovieCell.self, forCellWithReuseIdentifier: PopularMovieCell.reuseId)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.rx.setDelegate(self)
                         .disposed(by: disposeBag)
    }
}

extension PopularMoviesViewController: MoviesViewModelInput, MoviesViewModelOutput {
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
        movies.drive(collectionView.rx.items(cellIdentifier: PopularMovieCell.reuseId,
                                             cellType: PopularMovieCell.self),
                     curriedArgument: setupCell)
              .disposed(by: disposeBag)
    }

    func setupCell(idx: Int, viewModel: MovieViewModel, cell: PopularMovieCell) {
        cell.setup(with: viewModel)
    }

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        return layout
    }
}

extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width / 2) - 10
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}
