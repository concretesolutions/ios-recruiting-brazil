//
//  PopularMoviesGridViewModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift

protocol PopularMoviesGridViewModelType {
    var movies: Variable<[MovieModel]> { get }
    var requestError: Variable<(title: String, msg: String)?> { get }
    var showLoading: Variable<Bool> { get }
    
    func fetchMovies(search: String?)
}

final class PopularMoviesGridViewModel: PopularMoviesGridViewModelType {
    
    // MARK: Public Variables
    var movies = Variable<[MovieModel]>([])
    var requestError = Variable<(title: String, msg: String)?>(nil)
    var showLoading = Variable(false)
    
    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    private var page = 1
    private var service: PupolarMoviesGridService
    
    init() {
        self.service = PupolarMoviesGridService(provider: RequestProvider<MoviesTargetType>());
    }
    
    func fetchMovies(search: String? = nil) {
        guard  let search = search, search.count > 0 else {
            self.fetchPopularMovies()
            return
        }
        self.searchMovies(search: search)
    }
    
    private func fetchPopularMovies() {
        self.showLoading.value = true
        self.service.getPopularMovies(page: self.page).subscribe(onNext: {[weak self] response in
            self?.movies.value = response.results
            }, onError: {[weak self] _ in
                self?.requestError.value = (title: "Error", msg: "Request fail")
            }, onCompleted: {[weak self] in
                self?.showLoading.value = false
        }).disposed(by: disposeBag)
    }
    
    private func searchMovies(search: String) {
        self.showLoading.value = true
        self.service.searchMovies(search: search, page: self.page).subscribe(onNext: {[weak self] response in
            self?.movies.value = response.results
            }, onError: {[weak self] _ in
                self?.requestError.value = (title: "Error", msg: "Request fail")
            }, onCompleted: {[weak self] in
                self?.showLoading.value = false
        }).disposed(by: disposeBag)
    }
}
