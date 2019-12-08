//
//  Services.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 28/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire
import CoreData

class RequestAPI {
    
    private let apiKey = "dcfdbbf8648cddebeb0decb1f27aca9a"
    
    enum HttpMethod: String {
        case GET = "GET"
    }
    
    func setupBaseURL(fimURL: String) -> URL? {
        guard let url = URL(string: "https://api.themoviedb.org/3/\(fimURL)") else {
            return nil
        }
        
        return url
    }
    
    func pegarFilmesPopulares(pagina: Int, completion: @escaping(Swift.Result<[Filme],Error>) -> ()){

        var listaFilmesObj: [Filme] = []
        
        guard let url = setupBaseURL(fimURL: "movie/popular?api_key=\(apiKey)&language=pt-BR&page=\(pagina)") else {
            return
        }

        let request = NSMutableURLRequest(url: url,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = HttpMethod.GET.rawValue

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    
            if let erro = error {
                completion(.failure(erro))
            }
                    
            if let data = data {
                do {
                
                    let json = try JSONDecoder().decode(Lista.self, from: data)
                    
                    let semaforo = DispatchSemaphore(value: 1)
                
                    if json.total_pages < pagina {
                        semaforo.signal()
                        completion(.success(listaFilmesObj))
                    }
            
                    for result in json.results {
        
                        let _ = Filme(filmeDecodable: result) { (filme) in
                            listaFilmesObj.append(filme)
                            semaforo.signal()
                        }
                        
                        semaforo.wait()
                    }
                
                    completion(.success(listaFilmesObj))
            
                } catch {
                    completion(.failure(error))
                }
            }
        })
        
        dataTask.resume()
    }
   
   func pegarFilmesPorID(id: Int, completion: @escaping(Swift.Result<Filme,Error>) -> ()){
 
        guard let url = setupBaseURL(fimURL: "movie/\(id)?api_key=\(apiKey)&language=pt-BR") else {
            return
        }
       
        let request = NSMutableURLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
        request.httpMethod = HttpMethod.GET.rawValue

        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                       
            if let erro = error {
                completion(.failure(erro))
            }
                       
            if let data = data {
                do {
                   
                   let json = try JSONDecoder().decode(FilmeDecodable.self, from: data)
                   
                   let _ = Filme(filmeDecodable: json) { (filme) in
                        completion(.success(filme))
                   }
               
                } catch {
                    completion(.failure(error))
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
       
        guard let url = setupBaseURL(fimURL: "genre/movie/list?language=pt-BR&api_key=\(apiKey)&language=pt-BR") else {
            completion(nil)
            return
        }
    
        let request = NSMutableURLRequest(url: url,
                                                cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
       request.httpMethod =  HttpMethod.GET.rawValue

       let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                       
           if let _ = error {
               completion(nil)
           }
                       
           if let data = data {
               do{
                   let json = try JSONDecoder().decode(generosDetalhados.self, from: data)
                   completion(json)
               }catch{
                   completion(nil)
               }
           }else{
               completion(nil)
           }
       })
       
       dataTask.resume()
   }
}

class RequestFavoritos {
    
    let managedContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.managedContext = context
    }
    
    func salvarFavorito(id: Int){
        
        if pegarFavoritoPorId(id: id) != nil {
            deletarFavorito(id: id) { (_) in }
            return
        }
        
        guard let entity = NSEntityDescription.entity(forEntityName: "FilmeObj", in: managedContext) else { return }
                   
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
                   
        person.setValue(id, forKey: "id")
                   
        do{
            try managedContext.save()
        }catch _ as NSError{
            return
        }
                   
    }
    
    func pegarFavoritos() -> [Int] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FilmeObj")
        
        do{
            var favoritos: [Int] = []
            let coreDataObj = try managedContext.fetch(fetchRequest)
            for elemento in coreDataObj {
                favoritos.append(elemento.value(forKey: "id") as? Int ?? 0)
            }
            return favoritos
        }catch{
            return []
        }
    }
    
    func pegarFavoritoPorId(id: Int) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FilmeObj")
        
        do{
            let coreDataObj = try managedContext.fetch(fetchRequest)
            for elemento in coreDataObj {
                if elemento.value(forKey: "id") as? Int == id {
                    return elemento
                }
            }
            return nil
        }catch{
            return nil
        }
    }
    
    func deletarFavorito(id: Int, completion: @escaping(String?) -> ()){
        if let filme = pegarFavoritoPorId(id: id) {
            managedContext.delete(filme)
            do{
                try managedContext.save()
                completion(nil)
            }catch{
                completion("Nāo foi possivel deletar este filme dos favoritos")
            }
        }else{
            completion("Nāo foi possivel deletar este filme dos favoritos")
        }
        
    }

}

class Filtro {
    func aplicarFiltro(filmesFiltrados: [Filme], anoSelecionado: Int, generoSelecionado: String) -> [Filme]{
        if !anoSelecionado.isZero() && !generoSelecionado.isEmpty {
            return filmesFiltrados.filter({ (filme) -> Bool in
                return (filme.pegarAnoFilme() == anoSelecionado) && (filme.generoFormatado.contains(generoSelecionado))
            })
        }else if anoSelecionado.isZero() && !generoSelecionado.isEmpty {
            return filmesFiltrados.filter({ (filme) -> Bool in
                return (filme.generoFormatado.contains(generoSelecionado))
            })
        }else if !anoSelecionado.isZero() && generoSelecionado.isEmpty {
            return filmesFiltrados.filter({ (filme) -> Bool in
                return (filme.pegarAnoFilme() == anoSelecionado)
            })
        }
        
        return []
        
    }
}
