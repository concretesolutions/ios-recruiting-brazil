//
//  Category.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 07/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import Foundation

struct CategoryService{
    static func getCategory(callBack:@escaping (GeneralResponse<[Category]>)->Void){
        guard let url = URL(string:Constants.movieURL+"genre/movie/list?api_key="+Constants.movieDBAPIkey+"&language=pt-BR") else{
                callBack(GeneralResponse<[Category]>(error: .errorURL, success: nil))
                return
            };
        let configuration = URLSessionConfiguration.default
        URLSession(configuration: configuration).dataTask(with: url){
            data,response,error in
            
            guard error == nil,let resp = response as? HTTPURLResponse,resp.statusCode == 200 else{
                callBack(GeneralResponse<[Category]>(error: .errorURL, success: nil))
                return}
            guard let dataResponse = data else{
                callBack(GeneralResponse<[Category]>(error: .errorURL, success: nil))
                return
            }
            guard let genresDTO = try? JSONDecoder().decode(CategoryDTO.self, from: dataResponse)else{
                callBack(GeneralResponse<[Category]>(error: .errorJSON, success: nil))
                return
            }
            callBack(GeneralResponse<[Category]>(error: nil, success: genresDTO.genres))
                }.resume()
        }
}


