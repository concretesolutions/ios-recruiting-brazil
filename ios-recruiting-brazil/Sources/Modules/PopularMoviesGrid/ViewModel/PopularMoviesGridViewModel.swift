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
    var error: Variable<String?> { get }
    var showLoading: Variable<Bool> { get }
    
    func fetchMovies(search: String?)
}

final class PopularMoviesGridViewModel: PopularMoviesGridViewModelType {
    
    // MARK: Public Variables
    var movies = Variable<[MovieModel]>([])
    var error = Variable<String?>(nil)
    var showLoading = Variable(false)
    
    // MARK: Private Variables
    private let disposeBag = DisposeBag()
    private var popularPage = 1
    private var searchPage = 1
    private var service: PupolarMoviesGridService
    
    init() {
        self.service = PupolarMoviesGridService(provider: RequestProvider<MoviesTargetType>());
    }
    
    func fetchMovies(search: String? = nil) {
        self.error.value = nil
        var target = MoviesTargetType.popularMovies(self.popularPage)
        if let search = search, search.count > 0 {
            target = MoviesTargetType.filterMovies(search, self.searchPage)
        }
        self.service.fetchMovies(target: target).subscribe(onNext: {[weak self] response in
            guard !(response.results.count == 0) else {
                self?.error.value = "Sua busca não retornou resultados"
                return
            }
            
            if response.page == 1 {
                self?.movies.value = response.results
            } else {
                self?.movies.value.append(contentsOf: response.results)
            }
            self?.incrementPage(target: target, currentPage: response.page)
            }, onError: {[weak self] error in
                self?.error.value = "Um erro ocorreu por favor tente novamente"
            }, onCompleted: {[weak self] in
                self?.showLoading.value = false
        }).disposed(by: disposeBag)
    }
    
    private func incrementPage(target: MoviesTargetType, currentPage: Int) {
        switch target {
        case .popularMovies:
            self.searchPage = 1
            self.popularPage = currentPage + 1
        case .filterMovies:
            self.popularPage = 1
            self.searchPage = currentPage + 1
        }
    }
}
