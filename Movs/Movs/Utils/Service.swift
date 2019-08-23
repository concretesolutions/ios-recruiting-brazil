//
//  Service.swift
//  Movs
//
//  Created by Gustavo Caiafa on 14/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import Foundation
import Alamofire
import Haneke
import SwiftyJSON
import ObjectMapper
import Connectivity

public class Service{
    
    struct LinksAPI {
        static var GetPopularMovies = "https://api.themoviedb.org/3/movie/popular"
        static var GetGenres = "https://api.themoviedb.org/3/genre/movie/list"
    }
    
    typealias ServiceReponse = (AnyObject?) -> Void
    
    class func callMethodJson(_ controller: UIViewController,metodo : HTTPMethod,parametros : [String : AnyObject],url : String,nomeCache : String,status: Connectivity.Status, onCompletion : @escaping (AnyObject?,NSError?)-> Void){
        let cache = Shared.dataCache
        switch status {
        case .notConnected, .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .determining:
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {
                showAlertaController(controller, texto: "Você está offline, algumas funções podem ser comprometidas.", titulo: "Atenção!",dismiss: false)
            }
            if(!nomeCache.isEmpty){
                let infoError = [NSLocalizedDescriptionKey: "Internet não disponivel e cache com erro"]
                let erroNoNetErrorCache = NSError(domain: url, code: 408, userInfo: infoError)
                cache.fetch(key: nomeCache).onSuccess({ (ret) in
                    if let jsonRetorno = JSON.convertFromData(ret){
                        if(jsonRetorno.array != nil){
                            onCompletion(jsonRetorno.array as AnyObject?,nil)
                        }
                        else{
                            onCompletion(jsonRetorno.dictionary as AnyObject?,nil)
                        }
                    }
                    else{
                        onCompletion(nil, erroNoNetErrorCache)
                    }
                }).onFailure({ (error) in
                    onCompletion(nil, erroNoNetErrorCache)
                })
            }
            else{
                let infoError = [NSLocalizedDescriptionKey: "Internet não disponivel e sem nada no cache"]
                let error = NSError(domain: url, code: 408, userInfo: infoError)
                onCompletion(nil, error)
            }
        case .connected, .connectedViaCellular, .connectedViaWiFi:
            Alamofire.request(url, method: metodo, parameters: parametros, headers: nil).validate().responseJSON{ response in
                switch(response.result){
                case .success:
                    if(!nomeCache.isEmpty){
                        cache.set(value: response.data!, key: nomeCache)
                    }
                    onCompletion(response.result.value! as AnyObject?, nil)
                case .failure(let error):
                    print("Erro na requisicao do Alamofire: \(error)")
                    showAlertaController(controller, texto: "Ocorreu um erro na sua requisição. Por favor tente novamente!", titulo: "Atenção!",dismiss: false)
                    if(!nomeCache.isEmpty){
                        let infoError = [NSLocalizedDescriptionKey: "Requisicao Alamofire falhou e cache com erro"]
                        let errorApiNoCache = NSError(domain: url, code: response.response?.statusCode ?? 400, userInfo: infoError)
                        cache.fetch(key: nomeCache).onSuccess({ (ret) in
                            if let jsonRetorno = JSON.convertFromData(ret){
                                if(jsonRetorno.array != nil){
                                    onCompletion(jsonRetorno.array as AnyObject?,nil)
                                }
                                else{
                                    onCompletion(jsonRetorno.dictionary as AnyObject?,nil)
                                }
                            }
                            else{
                                onCompletion(nil, errorApiNoCache)
                            }
                        }).onFailure({ (error) in
                            onCompletion(nil,errorApiNoCache)
                        })
                    }
                    else{
                        let infoError = [NSLocalizedDescriptionKey: "Requisicao Alamofire falhou e cache vazio"]
                        let error = NSError(domain: url, code: response.response?.statusCode ?? 400, userInfo: infoError)
                        onCompletion(nil,error)
                    }
                }
            }
        }
    }
    
    
    class func callMethodJson(metodo : HTTPMethod,parametros : [String : AnyObject],url : String,nomeCache : String,status: Connectivity.Status, onCompletion : @escaping (AnyObject?,NSError?)-> Void){
        let cache = Shared.dataCache
        switch status {
        case .notConnected, .connectedViaWiFiWithoutInternet, .connectedViaCellularWithoutInternet, .determining:
            if(!nomeCache.isEmpty){
                let infoError = [NSLocalizedDescriptionKey: "Internet não disponivel e cache com erro"]
                let erroNoNetErrorCache = NSError(domain: url, code: 408, userInfo: infoError)
                cache.fetch(key: nomeCache).onSuccess({ (ret) in
                    if let jsonRetorno = JSON.convertFromData(ret){
                        if(jsonRetorno.array != nil){
                            onCompletion(jsonRetorno.array as AnyObject?,nil)
                        }
                        else{
                            onCompletion(jsonRetorno.dictionary as AnyObject?,nil)
                        }
                    }
                    else{
                        onCompletion(nil, erroNoNetErrorCache)
                    }
                }).onFailure({ (error) in
                    onCompletion(nil, erroNoNetErrorCache)
                })
            }
            else{
                let infoError = [NSLocalizedDescriptionKey: "Internet não disponivel e sem nada no cache"]
                let error = NSError(domain: url, code: 408, userInfo: infoError)
                onCompletion(nil, error)
            }
        case .connected, .connectedViaCellular, .connectedViaWiFi:
            Alamofire.request(url, method: metodo, parameters: parametros, headers: nil).validate().responseJSON{ response in
                switch(response.result){
                case .success:
                    if(!nomeCache.isEmpty){
                        cache.set(value: response.data!, key: nomeCache)
                    }
                    onCompletion(response.result.value! as AnyObject?, nil)
                case .failure(let error):
                    print("Erro na requisicao do Alamofire: \(error)")
                    if(!nomeCache.isEmpty){
                        let infoError = [NSLocalizedDescriptionKey: "Requisicao Alamofire falhou e cache com erro"]
                        let errorApiNoCache = NSError(domain: url, code: response.response?.statusCode ?? 400, userInfo: infoError)
                        cache.fetch(key: nomeCache).onSuccess({ (ret) in
                            if let jsonRetorno = JSON.convertFromData(ret){
                                if(jsonRetorno.array != nil){
                                    onCompletion(jsonRetorno.array as AnyObject?,nil)
                                }
                                else{
                                    onCompletion(jsonRetorno.dictionary as AnyObject?,nil)
                                }
                            }
                            else{
                                onCompletion(nil, errorApiNoCache)
                            }
                        }).onFailure({ (error) in
                            onCompletion(nil,errorApiNoCache)
                        })
                    }
                    else{
                        let infoError = [NSLocalizedDescriptionKey: "Requisicao Alamofire falhou e cache vazio"]
                        let error = NSError(domain: url, code: response.response?.statusCode ?? 400, userInfo: infoError)
                        onCompletion(nil,error)
                    }
                }
            }
        }
    }
    
    
    
    
}
