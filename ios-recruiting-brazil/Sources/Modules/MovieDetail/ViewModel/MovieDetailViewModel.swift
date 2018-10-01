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
    var imgFavorite: String { get }
    var reload: Variable<Bool> { get }
    
    func saveFavorite()
}

final class MovieDetailViewModel: MovieDetailViewModelType {

    private var movie: MovieModel
    private var service: MovieDetailServiceType
    private let disposeBag = DisposeBag()
    
    var reload = Variable(false)
    var title: String? {
        return self.movie.title
    }
    
    var year: String? {
        return self.movie.releaseYear
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
    
    var imgFavorite: String {
        guard self.service.fentMovieInRealm(id: self.movie.id) != nil else {
            return "favorite_gray_icon"
        }
        
        return "favorite_full_icon"
    }
    
    init(movie: MovieModel, service: MovieDetailServiceType) {
        self.movie = movie
        self.service = service
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
    
    func saveFavorite() {
        guard (service.fentMovieInRealm(id: self.movie.id)) != nil else {
            self.service.save(movie: self.movie)
            return
        }
        self.service.removeMovie(id: self.movie.id)
    }
}
