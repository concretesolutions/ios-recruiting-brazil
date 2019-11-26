//
//  FuncoesFilme.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 26/11/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation

class FuncoesFilme {
    
    func pegarFilmesPorNome(nome: String, pagina: Int, filtro: String, completion: @escaping([Filme]) -> () ){
        
        var listaFilmesObj: [Filme] = []
                      
        let url = "https://api.themoviedb.org/3/search/movie?api_key=dcfdbbf8648cddebeb0decb1f27aca9a&query=\(nome)&language=pt-BR"
               
        //TRATANDO CARACTERES ESPECIAIS NA URL
        let urlComespecial = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? ""
              
        let request = NSMutableURLRequest(url: NSURL(string: urlComespecial)! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                                  timeoutInterval: 10.0)
        request.httpMethod = "GET"

        let session = URLSession.shared
       
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                       
            if let erro = error {
               print(erro.localizedDescription)
               completion(listaFilmesObj)
            }
                       
            if let data = data {
                do {
                    let json = try JSONDecoder().decode(Lista.self, from: data)
               
                    for result in json.results {
                       
                        let filme = Filme(filmeDecodable: result)
                            
                        listaFilmesObj.append(filme)
                    
                    }
                    completion(listaFilmesObj)
            
               } catch {
                  
                   print(error)
                   
                   completion(listaFilmesObj)
               }
           }
                
      })

      dataTask.resume()
        
    }
    
}
