//
//  BaseRequestAPI.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
import CommonsModule

open class BaseRequestAPI {
    
    let urlSession =  URLSession.shared
    var dataTask: URLSessionDataTask?
    
    public init() {}
    
    public func stop() {
        dataTask?.cancel()
    }
    
    @discardableResult
    public init<Model: Decodable>(api: MtdbAPI, completion: @escaping (Result<Model, MtdbAPIError>) -> Void) {
        self.requestJson(api: api, completion: completion)
    }
    
    @discardableResult
    public init(api: MtdbAPI, completion: @escaping (Result<Data, MtdbAPIError>) -> Void) {
        guard let urlRequest = buildUrlRequest(api: api) else {
            completion(.failure(.baseUrlInvalid))
            return
        }
        
        self.dataTask = self.urlSession.dataTask(with: urlRequest, completionHandler: { (data, urlResponse, error) in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.emptyData))
            }
        })
        self.dataTask?.resume()
    }
    
    private func buildUrlRequest(api: MtdbAPI) -> URLRequest? {
        var urlComponent = URLComponents(string: api.absoluteURL.absoluteString)
        urlComponent?.queryItems = [
            URLQueryItem(name: "api_key", value: api.token),
            URLQueryItem(name: "language", value: api.language)
        ]
        
        var urlString = api.absoluteURL.absoluteString
        urlString += "?api_key=" + api.token
        urlString += "&language=" + api.language
        
        guard let url = URL(string: urlString) else {            
            return nil
        }
        
        let urlRequest = URLRequest(url: url, cachePolicy: api.cachePolicy, timeoutInterval: api.timeOut)
        return urlRequest
    }
    
    private func requestJson<Model: Decodable>(api: MtdbAPI, completion: @escaping (Result<Model, MtdbAPIError>) -> Void) {
        
        guard let urlRequest = buildUrlRequest(api: api) else {
            completion(.failure(.baseUrlInvalid))
            return
        }
        
        self.log(request: urlRequest)
        self.dataTask = self.urlSession.dataTask(with: urlRequest) { (data, urlResponse, error) in
            self.log(data: data, response: urlResponse as? HTTPURLResponse, error: error)
            if let httpResponse = urlResponse as? HTTPURLResponse {
                print("error \(httpResponse.statusCode)")
            }
            if let error = error {
                completion(.failure(MtdbAPIError.unexpected(error)))
            }
            
            do {
                if let data = data {
                    let object = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(object))
                } else {
                    completion(.failure(MtdbAPIError.emptyData))
                }
                
            } catch {
                
                do {
                    guard let data = data else {
                        completion(.failure(MtdbAPIError.emptyData))
                        return
                    }
                    _ = try JSONDecoder().decode(InvalidAccessModel.self, from: data)
                    completion(.failure(MtdbAPIError.invalidToken))
                    
                } catch {
                    
                }
                completion(.failure(MtdbAPIError.jsonDecoded))
            }
            
        }
        dataTask?.resume()
    }
}

//MARK: Loggin
extension BaseRequestAPI {
    
    func log(request: URLRequest){
        
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"
        
        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = request.httpBody{
                        
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            requestLog += "\n\(body.prettyPrintedJSONString)\n"
        }
        
        requestLog += "\n------------------------->\n";
        print(requestLog)
    }
    
    func log(data: Data?, response: HTTPURLResponse?, error: Error?){
        
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")
        
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        
        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }
        
        if let statusCode =  response?.statusCode{
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host{
            responseLog += "Host: \(host)\n"
        }
        for (key,value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data{
            let bodyString = NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "Can't render body; not utf8 encoded";
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error{
            responseLog += "\nError: \(error.localizedDescription)\n"
        }
        
        responseLog += "<------------------------\n";
        print(responseLog)
    }
    
}
