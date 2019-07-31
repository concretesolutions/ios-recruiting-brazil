//
//  MovieNetworkRepository.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import RxSwift

protocol MovieNetworkRepositoryProtocol {
    var getMoviesStream: Observable<(Int, [MovieEntity])> { get }
    
    func getMovies(page: Int)
}

final class MovieNetworkRepository: MovieNetworkRepositoryProtocol {
    
    private var service: TheMovieServiceAPI
    private var disposeBag = DisposeBag()
    
    private var getMoviesPublisher = PublishSubject<(Int, [MovieEntity])>()
    var getMoviesStream: Observable<(Int, [MovieEntity])> {
        get {
            return getMoviesPublisher.asObservable()
        }
    }
    
    init(service: TheMovieServiceAPI) {
        self.service = service
    }
    
    func getMovies(page: Int) {
        self.service.fetchMovies(page: page).bind(onNext: { [weak self] result  in
            switch result {
            case .success(let movieResponse):
                self?.getMoviesPublisher.onNext((page, movieResponse.results))
            case .failure(let error):
                self?.getMoviesPublisher.onError(error)
            }
        }).disposed(by: disposeBag)
    }
}
