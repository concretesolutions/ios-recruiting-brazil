//
//  PopularMovies.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation

class PopularMoviesService{
    static func getPopularMovies(page:Int,callBack:@escaping (GeneralResponse<[Movie]>)->Void){
        guard let url = URL(string:Constants.movieURL+"movie/popular?api_key="+Constants.movieDBAPIkey+"&language=pt-BR&page=\(page)") else{
                callBack(GeneralResponse<[Movie]>(error: .errorURL, success: nil))
                return
            };
        print(url.absoluteURL)
        let configuration = URLSessionConfiguration.default
        URLSession(configuration: configuration).dataTask(with: url){
            data,response,error in
            
            guard error == nil,let resp = response as? HTTPURLResponse,resp.statusCode == 200 else{
                callBack(GeneralResponse<[Movie]>(error: .errorURL, success: nil))
                return}
            guard let dataResponse = data else{
                callBack(GeneralResponse<[Movie]>(error: .errorURL, success: nil))
                return
            }
            
            guard let moviesDTO = try? JSONDecoder().decode(MovieDTO.self, from: dataResponse)else{
                callBack(GeneralResponse<[Movie]>(error: .errorJSON, success: nil))
                return
            }
            callBack(GeneralResponse<[Movie]>(error: nil, success: moviesDTO.results))
                }.resume()
        }
}
