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
}

class MovieDetailsPresenter {
    weak var view: MovieDetailsView?
    private let resourcesDataSource: ResourcesDataSource = ResourcesDataSourceImpl()
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
    }
}
