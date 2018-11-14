//
//  ServerManager.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

class ServerManager {
    
    //static let moviePlaceholder = UIImage.init(named: "Movie Placeholder")
    
    /**
     Teste call, retorna se usuario esta logado e uma mensagem caso esteja logdo
     - parameter handler: Função é executado depois que tudo ja foi feito e retorna o valor true quando logado e false quando deslogado
     */
    public static func getMovies(page:Int, handler: @escaping (([Movie], ResponseStatus)->Void) ) {
        let urlString = ServerURL.prepareMoviesURL(page: page)
        guard let url = URL(string: urlString) else { return }
        // Prepare request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // TASK
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    handler([], .error)
                }
                //return
            }else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    // Setup POST data
                    guard let data = data else { return }
                    do {
                        // Response Data
                        let decoder = JSONDecoder()
                        let serverData = try decoder.decode(Popular.self, from: data)
                        // Continue
                        DispatchQueue.main.async {
                            if let movies = serverData.results {
                                handler(movies, .okay)
                            }
                        }
                    } catch let err {
                        print("Error", err)
                    }
                    //print("CODE = 200")
                    //return
                }else{
                    DispatchQueue.main.async {
                        handler([], .error)
                    }
                }
            }
            
        }.resume()
    }
    
    /**
     Teste call, retorna se usuario esta logado e uma mensagem caso esteja logdo
     - parameter handler: Função é executado depois que tudo ja foi feito e retorna o valor true quando logado e false quando deslogado
     */
    public static func getMoviesSearch(page:Int, searchText: String,handler: @escaping (([Movie], ResponseStatus)->Void) ) {
        let urlString = ServerURL.prepareMoviesSearch(page: page, searchText: searchText)
        guard let url = URL(string: urlString) else { return }
        // Prepare request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // TASK
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    handler([], .error)
                }
                //return
            }else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    // Setup POST data
                    guard let data = data else { return }
                    do {
                        // Response Data
                        let decoder = JSONDecoder()
                        let serverData = try decoder.decode(Popular.self, from: data)
                        // Continue
                        DispatchQueue.main.async {
                            if let movies = serverData.results {
                                handler(movies, .okay)
                            }
                        }
                    } catch let err {
                        print("Error", err)
                    }
                    //print("CODE = 200")
                    //return
                }else{
                    DispatchQueue.main.async {
                        handler([], .error)
                    }
                }
            }
            
            }.resume()
    }
    
    /**
     Teste call, retorna se usuario esta logado e uma mensagem caso esteja logdo
     - parameter handler: Função é executado depois que tudo ja foi feito e retorna o valor true quando logado e false quando deslogado
     */
    public static func getMovieByID(movieID:Int, handler: @escaping ((MovieDetail?, ResponseStatus)->Void) ) {
        let urlString = ServerURL.prepareMoviesByID(id: movieID)
        guard let url = URL(string: urlString) else { return }
        // Prepare request
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // TASK
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    handler(nil, .error)
                }
                //return
            }else if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode == 200 {
                    // Setup POST data
                    guard let data = data else { return }
                    do {
                        // Response Data
                        let decoder = JSONDecoder()
                        let serverData = try decoder.decode(MovieDetail.self, from: data)
                        // Continue
                        DispatchQueue.main.async {
                            handler(serverData, .okay)
                        }
                    } catch let err {
                        print("Error", err)
                    }
                    //print("CODE = 200")
                    //return
                }else{
                    DispatchQueue.main.async {
                        handler(nil, .error)
                    }
                }
            }
            
            }.resume()
    }
    
    
}
