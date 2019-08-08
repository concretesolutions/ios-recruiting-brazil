//
//  RequestApi.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 07/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
final class RequestApi {
    enum TypeMethod:String {
        case GET = "GET",
        POST = "POST",
        PUT = "PUT",
        DELETE = "DELETE"
    }
    
    enum ContentType:String{
        case Text = "application/text",
        Json = "application/json"
    }
    
    private var _method:TypeMethod
    private var _contentType:ContentType
    
    
    init(_ method:TypeMethod, _ contentType:ContentType) {
        self._method = method
        self._contentType = contentType
        
    }
    
    private func createRequestWithMethod(url:URL, timeOut:Int, params:Data?, token:String ) -> NSMutableURLRequest{
        
        
        let request:NSMutableURLRequest! = NSMutableURLRequest(url: url)
        request.httpMethod = self._method.rawValue
        request.setValue(self._contentType.rawValue, forHTTPHeaderField: "Content-Type")

       
        if(params != nil){
            request.setValue( String(describing: params?.count), forHTTPHeaderField: "Content-Length")
            
            request.httpBody = params
            
        }

        if(!token.isEmpty){
            request.setValue("Token " + token.replacingOccurrences(of: "\\", with: ""), forHTTPHeaderField: "Authorization")
        }
        
        
        //Finaliza e retorna a requisição configurada.
        if(timeOut > 0){
            request.timeoutInterval = TimeInterval(timeOut)
        }
        else{
            request.timeoutInterval = TimeInterval(30)
        }
        
        return request
    }
    
     
    
    func requestWhithReturn(resource:Resource,timeOut:Int, token:String, completion:@escaping (DefaultDataResponse?) -> ()){
        let session:URLSession! = URLSession(configuration: URLSessionConfiguration.default)
        let request:NSMutableURLRequest! = createRequestWithMethod(url: resource.url, timeOut: timeOut, params: resource.dataObject, token: token)
        
        let task:URLSessionDataTask! = session.dataTask(with: request  as URLRequest) { (data, response, error) in
            
            if error != nil {
                completion(DefaultDataResponse(error: error!))
            }
            
            if let response = response as? HTTPURLResponse {
                completion(DefaultDataResponse(statusCode: response.statusCode, data: data))
            }
            else {
                completion(nil)
            }
        }
        
        task.resume()
    }
}
