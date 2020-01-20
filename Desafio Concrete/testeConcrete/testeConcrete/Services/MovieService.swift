//
//  Movies.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 07/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation
import UIKit

struct MovieService{
    static func getMovies(callBack:@escaping (GeneralResponse<[Movie]>)->Void){
        guard let url = URL(string:Constants.movieURL+"genre/movie/list?api_key="+Constants.movieDBAPIkey+"&language=pt-BR") else{
                callBack(GeneralResponse<[Movie]>(error: .errorURL, success: nil))
                return
            };
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
    static func getMoviePoster(urlPoster:String,callBack:@escaping (GeneralResponse<UIImage>)->Void){
        guard let url = URL(string:Constants.posterURL+"\(urlPoster)") else{
                       callBack(GeneralResponse<UIImage>(error: .errorURL, success: nil))
                       return
                   };
        let configuration = URLSessionConfiguration.default
        URLSession(configuration: configuration).dataTask(with: url){
           data,response,error in
           guard error == nil,let resp = response as? HTTPURLResponse,resp.statusCode == 200 else{
               callBack(GeneralResponse<UIImage>(error: .errorURL, success: nil))
               return}
            
           guard let dataResponse = data else{
               callBack(GeneralResponse<UIImage>(error: .errorURL, success: nil))
               return
           }
            
            guard let imageView = UIImage(data: dataResponse) else{
                callBack(GeneralResponse<UIImage>(error: .errorDataImage, success: nil))
                return
            }
        
            callBack(GeneralResponse<UIImage>(error: nil, success: imageView))
        }.resume()
        
    }
}
