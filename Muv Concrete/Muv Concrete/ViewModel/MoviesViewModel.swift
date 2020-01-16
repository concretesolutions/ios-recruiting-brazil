//
//  MoviesViewModel.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 15/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

class MoviesViewModel {
    
    var delegate: UIViewController?
    
    var arrayMovies: [Movie] = []
    
    public func loadMovies(){
        guard let delegate = delegate as? ViewController else {
            return }
        if delegate.arrayMovies.isEmpty {
            requestMovies()
        }
    }
    
    private func requestMovies(){
        let serviceRouteMovies = ServiceRoute.popularMovie(1)
        let request = Request.instance
        request.dispatch(endPoint: serviceRouteMovies, type: Content.self, completionHandler: { (data, response, error) in
            
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
                        self.saveMovies(movies: data.results)
                    }
                default:
                    print("nao rolou")
//                    self.delegate?.showAlert(withTitle: "Alerta", andMessage: "Desculpa o transtorno, houve um erro inesperado.")
                }
            }
        })
    }
    
    private func saveMovies(movies: [Movie]) {
        arrayMovies = movies
        guard let delegate = delegate as? ViewController else {
        return }
        delegate.loadMovies()
    }
}
