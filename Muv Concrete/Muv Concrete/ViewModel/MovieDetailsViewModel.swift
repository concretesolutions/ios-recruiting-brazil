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
    var movie: Movie?
    
//    salvar os ids em um array useDefaults
    
    public func requestMovies(completionHandler: @escaping (Bool) -> Void){
        guard let idMovie = id else { return }
        
        let serviceRouteMovies = ServiceRoute.movie(idMovie)
        let request = Request.instance
        request.dispatch(endPoint: serviceRouteMovies, type: Movie.self, completionHandler: { (data, response, error) in
            
            guard let response = response else {
//                self.delegate?.showAlert(withTitle: "Falha na conexão", andMessage: "Não foi possível comunicar com o servidor, tente novamente mais tarde.")
                print("Deu errado")
                return
            }
            
            DispatchQueue.main.async {
                switch response.statusCode {
                case 200:
                    DispatchQueue.main.async {
                        guard let data = data else { return }
                        self.movie = data
                        completionHandler(true)
//                        self.saveMovies(movies: data.results)
                    }
                default:
                    print("nao rolou")
//                    self.delegate?.showAlert(withTitle: "Alerta", andMessage: "Desculpa o transtorno, houve um erro inesperado.")
                }
            }
        })
    }
    
    public func getMovie(indexPath: IndexPath) -> Movie? {
        return movie
    }
}
