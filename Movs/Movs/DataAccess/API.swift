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
//        autenticar()
    }
    
    func getFilmesTendencia(da janelaTempo: JanelaTempoEnum = .semana, tipoMidia: String = "movie",
                            _ completionHandler: (TMDBResponse?) -> Void) {
//        guard let sessionResponse = self.session as? CreateSessionResponse,
//              sessionResponse.success == true else { completionHandler(session); return }
        
        let urlRequest = Endpoint.trending().url
        
        AF.request(urlRequest, headers: HTTPHeaders([])).response { response in
            debugPrint(response)
        }
    }
    
//    private func autenticar() {
//        if session != nil { return }
//
//        preAutenticar {
//            guard let requestTokenResponse = self.requestToken as? RequestTokenResponse,
//                  requestTokenResponse.success == true else { return }
//
//            let urlRequest = Endpoint.createSession(with: self.chaveApi).url
//            let body = [ "request_token": requestTokenResponse.requestToken ]
//
//            AF.request(urlRequest, parameters: body).response { response in
//                let decoder = JSONDecoder()
//
//                switch response.result {
//                case let .success(data):
//                    guard let data = data else { return }
//                    let decodedData = try? decoder.decode(CreateSessionResponse.self, from: data)
//                    let decodedErro = try? decoder.decode(TMDBError.self, from: data)
//                    self.session = decodedData ?? decodedErro
//                case let .failure(erro):
//                    self.session = TMDBError(
//                        statusMessage: erro.errorDescription ?? "",
//                        statusCode: erro.responseCode ?? 999
//                    )
//                }
//            }
//        }
//    }
//
//    private func preAutenticar(_ completionHandler: @escaping () -> Void) {
//        if requestToken != nil { completionHandler(); return }
//
//        let urlRequest = Endpoint.createRequestToken(with: chaveApi).url
//
//        AF.request(urlRequest).response { response in
//            let decoder = JSONDecoder()
//
//            switch response.result {
//            case let .success(data):
//                guard let data = data else { return }
//                let decodedData = try? decoder.decode(RequestTokenResponse.self, from: data)
//                let decodedErro = try? decoder.decode(TMDBError.self, from: data)
//                self.requestToken = decodedData ?? decodedErro
//            case let .failure(erro):
//                self.requestToken = TMDBError(
//                    statusMessage: erro.errorDescription ?? "",
//                    statusCode: erro.responseCode ?? 999
//                )
//            }
//
//            completionHandler()
//        }
//    }
    
}
