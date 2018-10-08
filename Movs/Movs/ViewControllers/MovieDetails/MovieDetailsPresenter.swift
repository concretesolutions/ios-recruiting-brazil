//
//  MovieDetailsPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 04/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol MovieDetailsView: AnyObject {
    func setup(with movie: Movie)
    func presenter(_ presenter: MovieDetailsPresenter, didFetchImage image: UIImage)
    func setFavorite(to favorite: Bool)
}

class MovieDetailsPresenter {
    weak var view: MovieDetailsView?
    private let resourcesDataSource: ResourcesDataSource = ResourcesDataSourceImpl()
    private let popularMoviesUseCase = MoviesUseCase()
    private let movie: Movie
    private let disposeBag = DisposeBag()

    init(movie: Movie) {
        self.movie = movie
    }

    func onStart() {
        view?.setup(with: movie)
        resourcesDataSource.requestImage(resource: movie.posterPath)
            .subscribe(onSuccess: { (image: UIImage?) in
                if let image = image {
                    self.view?.presenter(self, didFetchImage: image)
                }
            }, onError: { (error: Error) in
                // TODO
            })
            .disposed(by: disposeBag)
        view?.setFavorite(to: movie.isFavorited)
    }

    func onFavoriteAction() {
        if !movie.isFavorited {
            movie.isFavorited = true
            notifyMovieChanged()
            view?.setFavorite(to: true)
            popularMoviesUseCase.favoriteMovie(movie)
                .subscribe(onError: { _ in
                    self.movie.isFavorited = false
                    self.notifyMovieChanged()
                    self.view?.setFavorite(to: false)
                })
                .disposed(by: disposeBag)
        } else {
            movie.isFavorited = false
            notifyMovieChanged()
            view?.setFavorite(to: false)
            popularMoviesUseCase.unfavoriteMovie(movie)
                .subscribe(onError: { (error: Error) in
                    self.movie.isFavorited = true
                    self.notifyMovieChanged()
                    self.view?.setFavorite(to: true)
                })
                .disposed(by: disposeBag)
        }
    }

    private func notifyMovieChanged() {
        NotificationCenter.default.post(name: NSNotification.Name.movie, object: movie)
    }
}
