//
//  API.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation
import Alamofire

protocol TheMovieDBAPI {
    func getMovie(id movieId: Int, _ completionHandler: @escaping (Data?) -> Void)
    func getImage(path: String, _ completionHandler: @escaping (Data?) -> Void)
    func getTrending(_ completionHandler: @escaping (Data?) -> Void)
    func getTrending(page: Int, _ completionHandler: @escaping (Data?) -> Void)
}

class API: TheMovieDBAPI {
    private let apiKey: String
    
    init() {
        apiKey = "43c36ace63ae7ab00bcc44feea1df181"
    }

    func getMovie(id movieId: Int, _ completionHandler: @escaping (Data?) -> Void) {
        let urlRequest = Endpoint.movie(id: movieId, with: apiKey).url
        
        AF.request(urlRequest)
            .validate(statusCode: 200...299)
            .response { response in completionHandler(response.data) }
    }
    
    func getImage(path: String, _ completionHandler: @escaping (Data?) -> Void) {
        let urlRequest = "https://image.tmdb.org/t/p/w500/\(path)"
        
        AF.request(urlRequest).responseImage { image in
            var downloadedImage: Data?
            switch image.result {
            case let .success(image):
                downloadedImage = image.pngData()
            case let .failure(error):
                debugPrint(error)
            }
            completionHandler(downloadedImage)
        }
    }
    
    func getTrending(_ completionHandler: @escaping (Data?) -> Void) {
        self.getTrending(da: .semana, tipoMidia: "movie", completionHandler)
    }
    
    func getTrending(page: Int, _ completionHandler: @escaping (Data?) -> Void) {
        self.getTrending(da: .semana, tipoMidia: "movie", pagina: page, completionHandler)
    }
    
    func getTrending(da janelaTempo: JanelaTempoEnum = .semana, tipoMidia: String = "movie",
                            pagina: Int = 1, _ completionHandler: @escaping (Data?) -> Void) {
        let urlRequest = Endpoint.trending(page: pagina, with: apiKey).url
        
        AF.request(urlRequest)
            .validate(statusCode: 200...299)
            .response { response in completionHandler(response.data) }
    }
}
