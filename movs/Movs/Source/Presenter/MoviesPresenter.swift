//
//  MoviesPresenter.swift
//  movs
//
//  Created by Lorien Moisyn on 17/04/19.
//  Copyright © 2019 Auspex. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MoviesPresenter {
    
    var movies: [Movie] = []
    var moviesVC: MoviesCollectionViewController!
    var repository: AlamoRemoteSource!
    var disposeBag = DisposeBag()
    var pageIndex = 1
    var isRequesting = false
    
    init(vc: MoviesCollectionViewController) {
        moviesVC = vc
        repository = AlamoRemoteSource()
    }
    
    func getNewPage() {
        pageIndex += 1
        getMovies()
    }
    
    func getMovies() {
        isRequesting = true
        repository
            .getTopMovies(at: pageIndex)
            .do(onSuccess: { (movies) in
                self.movies += movies
            })
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { _ in
                self.moviesVC.updateLayout()
            }, onCompleted: {
                self.isRequesting = false
            })
            .disposed(by: disposeBag)
    }
    
}
