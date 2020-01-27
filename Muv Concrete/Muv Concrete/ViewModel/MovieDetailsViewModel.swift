//
//  MovieDetailsViewModel.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 23/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MovieDetailsViewModel {
    
    var delegate: UIViewController?
    
    var id: Int32?
    var movie: MovieId?
    var genres = ""
    var date = ""
    var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 350))
    
    public func requestMovie(completionHandler: @escaping (Bool) -> Void){
        guard let idMovie = id else { return }
        
        let serviceRouteMovies = ServiceRoute.movie(idMovie)
        let request = Request.instance
        request.dispatch(endPoint: serviceRouteMovies, type: MovieId.self, completionHandler: { (data, response, error) in
            
            guard let response = response else {
                self.delegate?.showAlert(withTitle: "Falha na conexão", andMessage: "Não foi possível comunicar com o servidor, tente novamente mais tarde.")
                return
            }
            
            DispatchQueue.main.async {
                switch response.statusCode {
                case 200:
                    DispatchQueue.main.async {
                        guard let data = data else { return }
                        self.movie = data
                        self.setImage()
                        self.loadGenres(movie: data)
                        self.loadDate(movie: data)
                        completionHandler(true)
                    }
                default:
                    self.delegate?.showAlert(withTitle: "Alerta", andMessage: "Desculpa o transtorno, houve um erro inesperado.")
                }
            }
        })
    }
    
    public func getMovie() -> MovieId? {
        return movie
    }
    
    private func loadGenres(movie: MovieId) {
        var arrayGenre: [String] = []
        let genresMovie = movie.genres
        arrayGenre = genresMovie.map({ $0.name })
        genres = arrayGenre.joined(separator:", ")
    }
    
    public func checkFavorite(id: Int32, completionHandler: @escaping (Bool) -> Void){
        let defaults = UserDefaults.standard
        let arrayFavoritesIds = defaults.array(forKey: "favoritesIds")
        if arrayFavoritesIds != nil {
            let arrayIds = arrayFavoritesIds as! [Int32]
            if arrayIds.contains(id) {
                completionHandler(true)
            } else {
                completionHandler(false)
            }
        }
    }
    
    private func loadDate(movie: MovieId) {
        if let date = movie.releaseDate.split(separator: "-").first {
            self.date = String(date)
        }
    }
    
    public func setImage() {
        guard let path = movie?.posterPath else { return }
        imageView.downloaded(from: path, contentMode: .scaleToFill)
    }
}
