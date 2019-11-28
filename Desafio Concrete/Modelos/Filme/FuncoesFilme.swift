//
//  FuncoesFilme.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire

class FuncoesFilme {
    
    func pegarFilmesPopulares(pagina: Int, completion: @escaping([Filme], String?) -> ()){

         var listaFilmesObj: [Filme] = []
        
         let url = "https://api.themoviedb.org/3/movie/popular?api_key=dcfdbbf8648cddebeb0decb1f27aca9a&language=pt-BR&page=\(pagina)"
        
         let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                  cachePolicy: .useProtocolCachePolicy,
                                                    timeoutInterval: 10.0)
         request.httpMethod = "GET"

         let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                         
             if let erro = error {
                print(erro.localizedDescription)
                completion([],"\(erro.localizedDescription)")
             }
                         
             if let data = data {
                 do {
                     //let informacoesPesquisa = try JSONDecoder().decode(InformacoesPesquisa.self, from: data)
                     
                     let json = try JSONDecoder().decode(Lista.self, from: data)
                     
                     let semaforo = DispatchSemaphore(value: 1)
                     
                     if json.total_pages < pagina {
                         
                         semaforo.signal()
                         completion(listaFilmesObj, nil)
                     }
                
                     for result in json.results {
         
                         let _ = Filme(filmeDecodable: result) { (filme) in
                             listaFilmesObj.append(filme)
                             semaforo.signal()
                         }
                         
                         semaforo.wait()
                     }
                 
                     completion(listaFilmesObj, nil)
             
                } catch {
                   
                    print(error)
                    
                     completion(listaFilmesObj, error.localizedDescription)
                }
            }
        })
         
         dataTask.resume()
    }
    
    func pegarFilmesPorID(id: Int, completion: @escaping(Filme?, String?) -> ()){
  
        let url = "https://api.themoviedb.org/3/movie/\(id)?api_key=dcfdbbf8648cddebeb0decb1f27aca9a&language=pt-BR"
        
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                 cachePolicy: .useProtocolCachePolicy,
                                                   timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                        
            if let erro = error {
                print(erro.localizedDescription)
                completion(nil,nil)
            }
                        
            if let data = data {
                do {
                    
                    let json = try JSONDecoder().decode(FilmeDecodable.self, from: data)
                    
                    let _ = Filme(filmeDecodable: json) { (filme) in
                        completion(filme,nil)
                    }
                
                } catch {
                    print(error)
                    completion(nil,nil)
                }
            }
        })
        
        dataTask.resume()
    }
    
    func baixarPosterFilme(filme: FilmeDecodable, completion: @escaping(UIImage) -> ()){
        
        guard let url = filme.poster_path else {
            completion(UIImage())
            return
        }
        
        Alamofire.request("http://image.tmdb.org/t/p/w300\(url)").responseImage { (response) in
            if let result = response.result.value {
                completion(result)
            } else {
                completion(UIImage())
            }
        }
    }
    
    func baixarGeneros(completion: @escaping(generosDetalhados?) -> ()){
        
        let url = "https://api.themoviedb.org/3/genre/movie/list?language=pt-BR&api_key=dcfdbbf8648cddebeb0decb1f27aca9a"
       
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL,
                                                 cachePolicy: .useProtocolCachePolicy,
                                                   timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                        
            if let erro = error {
                print(erro.localizedDescription)
                completion(nil)
            }
                        
            if let data = data {
                do{
                    let json = try JSONDecoder().decode(generosDetalhados.self, from: data)
                    completion(json)
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        })
        
        dataTask.resume()
    }
    
    func verificarGenerosFilme(generosID: [Int], completion: @escaping([String]) -> ()){
        
        var generosString = [String]()
        
        baixarGeneros { (result) in
            
            if let result = result,
                let generos = result.genres {
                
                for elemento in generos {
                    if generosID.contains(elemento.id ?? 0) {
                        generosString.append(elemento.name ?? "")
                    }
                }
                
                completion(generosString)
                
            }else{
                completion([])
            }
        }
    
    }
    
    func tirarFilmeFavorito(index: Int){
        var favoritos = pegarListaFavoritos()
        
        favoritos.remove(at: index)
        
        UserDefaults.standard.set(favoritos, forKey: "favoritos")
        
    }
    
    func salvarFilmeFavorito(id: Int, filme: Filme){
        
        var favoritos = pegarListaFavoritos()
        let indexPossivelFav = verificarFavorito(id: id, filme: filme)
        
        if indexPossivelFav == -1 {
            favoritos.append(filme.filmeDecodable.id ?? 0)
            UserDefaults.standard.set(favoritos, forKey: "favoritos")
        }else{
            tirarFilmeFavorito(index: indexPossivelFav)
        }
            
    }
    
    func verificarFavorito(id: Int, filme: Filme) -> Int{
        
        let favoritos = pegarListaFavoritos()
        
        for (index, favorito) in favoritos.enumerated() {
            if filme.filmeDecodable.id == favorito {
                return index
            }
        }
        return -1
    }
    
    func pegarListaFavoritos() -> [Int] {
        
        if let idFavoritos = UserDefaults.standard.value(forKey: "favoritos") as? [Int] {
            return idFavoritos
        }else{
           return []
        }
        
    }
    
    static func pegarAnoFilme(filme: Filme) -> Int{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
           
        let dataLancamento = formatter.date(from: filme.filmeDecodable.release_date ?? "") ?? Date()
        
        let userCalendar = Calendar.current
     
        let ano = userCalendar.component(.year, from: dataLancamento)
        
        return ano
    }
    
}
