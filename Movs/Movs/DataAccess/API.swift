//
//  API.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation
import Alamofire

protocol TheMovieDBAPI {
    func getFilmesTendencia(da janelatempo: JanelaTempoEnum, tipoMidia: String, _ completionHandler: (TMDBResponse?) -> Void)
}

class API: TheMovieDBAPI {
    private var requestToken: TMDBResponse?
    private var session: TMDBResponse?
    
    private let chaveApi: String
    
    init() {
        chaveApi = "43c36ace63ae7ab00bcc44feea1df181"
    }
    
    func getFilmesTendencia(da janelaTempo: JanelaTempoEnum = .semana, tipoMidia: String = "movie",
                            _ completionHandler: (TMDBResponse?) -> Void) {
        let urlRequest = Endpoint.trending(with: chaveApi).url
        
        AF.request(urlRequest).response { response in
            debugPrint(response)
        }
    }
}
