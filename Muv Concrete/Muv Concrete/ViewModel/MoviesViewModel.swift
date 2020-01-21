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
    var pageRequest = 1
    var limitPage: Int32 = 0
    
//    salvar os ids em um array useDefaults
    
    public func requestMovies(completionHandler: @escaping (Bool) -> Void){
        let serviceRouteMovies = ServiceRoute.popularMovie(pageRequest)
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
                        self.limitPage = data.totalPages
                        self.arrayMovies += data.results
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
    
    public func loadMoreMovies(indexPath: IndexPath, completionHandler: @escaping (Bool) -> Void) {
        if indexPath.row == arrayMovies.count - 4, limitPage > pageRequest {
            pageRequest += 1
            print(pageRequest)
            requestMovies(completionHandler: {
                reloadCollectionView in
                completionHandler(reloadCollectionView)
            })
        }
    }
    
    public func getMovie(indexPath: IndexPath) -> Movie {
        return arrayMovies[indexPath.row]
    }
}
