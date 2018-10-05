//
//  MoviesCellPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 03/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieCellItem: AnyObject {
    func moviesCellPresenter(presenter: MoviesCellPresenter, didFetchImage image: UIImage)
    func setFavorite(to favorite: Bool)
}

class MoviesCellPresenter {

    private weak var view: MovieCellItem?
    private let disposeBag = DisposeBag()
    private let imagesDataSource: ResourcesDataSource = ResourcesDataSourceImpl()
    private let popularMoviesUseCase = MoviesUseCase()

    init(view: MovieCellItem) {
        self.view = view
    }

    func onMovieSet(movie: Movie) {
        imagesDataSource.requestImage(resource: movie.posterPath)
            .subscribe(onSuccess: { (image: UIImage?) in
                if let image = image {
                    self.view?.moviesCellPresenter(presenter: self, didFetchImage: image)
                }
            }, onError: { (error: Error) in
                // TODO
            })
            .disposed(by: disposeBag)
    }

    func onFavoriteAction(movie: Movie) {
        if !movie.isFavorited {
            movie.isFavorited = true
            view?.setFavorite(to: true)
            popularMoviesUseCase.favoriteMovie(movie)
                .subscribe(onError: { _ in
                    movie.isFavorited = false
                    self.view?.setFavorite(to: false)
                })
                .disposed(by: disposeBag)
        } else {
            movie.isFavorited = false
            view?.setFavorite(to: false)
            popularMoviesUseCase.unfavoriteMovie(movie)
                .subscribe(onError: { (error: Error) in
                    movie.isFavorited = true
                    self.view?.setFavorite(to: true)
                })
                .disposed(by: disposeBag)
        }
    }
}
