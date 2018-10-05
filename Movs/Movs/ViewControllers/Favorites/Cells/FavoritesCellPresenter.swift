//
//  FavoritesCellPresenter.swift
//  Movs
//
//  Created by Dielson Sales on 04/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

protocol FavoriteCellItem: AnyObject {
    func moviesCellPresenter(presenter: FavoritesCellPresenter, didFetchImage image: UIImage)
}

class FavoritesCellPresenter {

    weak var view: FavoriteCellItem?
    private let disposeBag = DisposeBag()
    private let imagesDataSource: ResourcesDataSource = ResourcesDataSourceImpl()

    init(view: FavoriteCellItem) {
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
