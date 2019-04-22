//
//  TMDBClient.swift
//  Movs
//
//  Created by Ygor Nascimento on 17/04/19.
//  Copyright © 2019 Ygor Nascimento. All rights reserved.
//

import Foundation

class TMDBClient {
    
    //Network Stack
    private static let tmdbBaseUrl = "https://api.themoviedb.org/3/movie/popular?api_key=3d3a97b3f7d3075c078e242196e44533"
    private static let tmdbBaseImageURL = "https://image.tmdb.org/t/p/w500"
    
    private static let sessionConfiguration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 20.0
        config.httpMaximumConnectionsPerHost = 10
        return config
    }()
    
    private static let session = URLSession(configuration: sessionConfiguration)
    
    class func loadMovies(onComplete: @escaping (Movie) -> Void, onError: @escaping (ApiError) -> Void) {
        //Adding Spinning to View
        
        
        //Adding the url inside the URL object
        guard let url = URL(string: tmdbBaseUrl) else {
            onError(.url)
            return
        }
        
        //Configurando o Datatask da session
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            
            //Tratando erros de acesso à rede do app, se existir um erro, não é viável continuar o processo de requesição
            if error == nil {
                //Tratando o status code que o servidor vai retornar
                guard let response = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    return
                }
                if response.statusCode == 200 {
                    //Tratando os dados recebidos do servidor
                    guard let data = data else {return}
                    do {
                        let movies = try JSONDecoder().decode(Movie.self, from: data)
                        onComplete(movies)
                    } catch {
                        onError(.invalidJSON)
                        print("Houve um erro ao fazer o decode dos dados.....", error.localizedDescription)
                    }
                } else {
                    onError(.responseStatusCode(code: response.statusCode))
                    print("Servidor não está respondendo status 200!")
                }
            } else {
                onError(.taskError(error: error!))
            }
        }
        dataTask.resume()
    }
}
