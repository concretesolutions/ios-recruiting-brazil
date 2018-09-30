//
//  MovieDetailViewModel.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import RxSwift

protocol MovieDetailViewModelType {
    var title: String? { get }
    var year: String? { get }
    var desc: String? { get }
    var gender: String? { get }
    var imgURL: String { get }
    var reload: Variable<Bool> { get }
}

final class MovieDetailViewModel: MovieDetailViewModelType {

    private var movie: MovieModel
    private var service: MovieDetailService
    private let disposeBag = DisposeBag()
    
    var reload = Variable(false)
    var title: String? {
        return self.movie.title
    }
    
    var year: String? {
        return String(self.movie.releaseDate.split(separator: "-")[0])
    }
    
    var desc: String? {
        return self.movie.desc
    }
    
    var gender: String? {
        var genders = ""
        self.movie.genders.forEach { genders = "\(genders)\($0.name ?? "")," }
        return String(genders.dropLast())
    }
    
    var imgURL: String {
        return "https://image.tmdb.org/t/p/w400\(movie.posterPath)"
    }
    
    init(movie: MovieModel) {
        self.movie = movie
        self.service = MovieDetailService(provider: RequestProvider<MovieDetailTargetType>())
        self.fetchGender()
    }
    
    private func fetchGender() {
        self.service.fetGender().reduce(self.movie, accumulator: { (movie, genders) -> MovieModel in
            let filter = genders.filter({ self.movie.genders.contains($0) })
            var newMovie = movie
            newMovie.genders = filter
            return newMovie
        }).subscribe(onNext: {[weak self] movie in
            self?.movie = movie
            self?.reload.value = true
        }, onError: { error in
            print(error.localizedDescription)
        }).disposed(by: self.disposeBag)
    }
}
