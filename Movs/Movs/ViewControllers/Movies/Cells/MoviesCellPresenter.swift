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
}

class MoviesCellPresenter {

    private weak var view: MovieCellItem?
    private let disposeBag = DisposeBag()
    private var imagesDataSource: ResourcesDataSource = ResourcesDataSourceImpl()

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
}
