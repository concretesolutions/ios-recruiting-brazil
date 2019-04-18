//
//  FavoritesPresenter.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Lorien. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FavoritesPresenter {
    
    var favorites: [Movie] = []
    var favoritesVC: FavoritesViewController?
    var repository: AlamoRemoteSource?
    var disposeBag = DisposeBag()
    
    var pageIndex = 1
    var isRequesting = false

    init(vc: FavoritesViewController) {
        favoritesVC = vc
        repository = AlamoRemoteSource()
    }
    
    func getNewPage() {
        pageIndex += 1
        getFavorites()
    }
    
    func getFavorites() {
        isRequesting = true
        repository?
            .getTopMovies(at: pageIndex)
            .do(onSuccess: { (movies) in
                self.favorites += movies
            })
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { _ in
                self.favoritesVC?.updateData()
            }, onCompleted: {
                self.isRequesting = false
            })
            .disposed(by: disposeBag)
    }
    
}
