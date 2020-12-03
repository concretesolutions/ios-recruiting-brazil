//
//  API.swift
//  Movs
//
//  Created by Gabriel Coutinho on 30/11/20.
//

import Foundation
import Alamofire

protocol TheMovieDBAPI {
    func getFilmesTendencia(_ completionHandler: @escaping (Data?) -> Void)
    func getFilmesTendencia(pagina: Int, _ completionHandler: @escaping (Data?) -> Void)
}

class API: TheMovieDBAPI {
    private let apiKey: String
    
    init() {
        apiKey = "43c36ace63ae7ab00bcc44feea1df181"
    }

    func getFilmesTendencia(_ completionHandler: @escaping (Data?) -> Void) {
        self.getFilmesTendencia(da: .semana, tipoMidia: "movie", completionHandler)
    }
    
    func getFilmesTendencia(pagina: Int, _ completionHandler: @escaping (Data?) -> Void) {
        self.getFilmesTendencia(da: .semana, tipoMidia: "movie", pagina: pagina, completionHandler)
    }
    
    func getFilmesTendencia(da janelaTempo: JanelaTempoEnum = .semana, tipoMidia: String = "movie",
                            pagina: Int = 1, _ completionHandler: @escaping (Data?) -> Void) {
        let urlRequest = Endpoint.trending(page: pagina, with: apiKey).url
        
        AF.request(urlRequest)
            .validate(statusCode: 200...299)
            .response { response in completionHandler(response.data) }
    }
}
