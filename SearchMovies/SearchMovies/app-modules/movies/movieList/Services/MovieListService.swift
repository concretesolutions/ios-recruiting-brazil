//
//  MovieListService.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class MovieListService {
    func getMovies(appKey:String, pageNumber:Int, completion: @escaping (_ result: GenericResult) -> Void ) {
        
        let urlStr:String = "\(Constants.imdbBaseUrl)/movie/popular?api_key=\(Constants.appKey)&language=\(Constants.imdbLanguageDefault)"
        let url:URL = URL(string: urlStr)!
        let resorceObject:Resource = Resource(url: url, dataObject: nil)
        
        let request:RequestApi = RequestApi(.GET, RequestApi.ContentType.Json)
        
        request.requestWhithReturn(resource: resorceObject, timeOut: 0, token: "") { (response) in
               if response == nil {
                  completion(GenericResult(objectReturn: nil, messageReturn: "", typeReturnService: .error))
               }
            
               if response!.error != nil {
                    completion(GenericResult(objectReturn: nil, messageReturn: response!.error?.localizedDescription, typeReturnService: .error))
                }
            
                guard let data = response!.data else { return }
                let movies:MovieListResult = try! JSONDecoder().decode(MovieListResult.self, from: data)
 
            completion(GenericResult(objectReturn: movies as AnyObject, messageReturn: "", typeReturnService: .success))
        }
  
        
        
        //https://api.themoviedb.org/3/movie/popular?api_key=<<api_key>>&language=en-US&page=1
    }
}


/*
 func getReceipts( _ startDate:String?, _ endDate:String?, _ order:String, completion: @escaping ( _ success: Bool, _ result: AnyObject?) -> Void ) {
 var result: AnyObject!
 let request: WSRequest = WSRequest(Endpoints.receipt().get)
 request.appendUrlQuery(["Inicio":startDate])
 request.appendUrlQuery(["Fim":endDate])
 request.appendUrlQuery(["Ordem":order])
 WebService.shared.requestWithoutErrorTreatment(request) { response in
 guard let data = response.data else { return }
 do {
 if response.statusCode == 200 {
 result = try JSONDecoder().decode(ReceiptDataList.self, from: data) as AnyObject
 }
 else {
 result = try JSONDecoder().decode(GenericModelReturn.self, from: data) as AnyObject
 }
 completion(true, result)
 } catch {
 completion(false, GenericModelReturn.genericError() as AnyObject)
 }
 }
 }
 */
