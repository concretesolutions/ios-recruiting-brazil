//
//  API.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

// MARK: - API info

enum API {
    static var link:String {
        return "https://api.themoviedb.org/3"
    }
    static var key:String {
        return "8d281a5a29fd9f6438c037919a13ae88"
    }
    static var imageLink:String {
        return "https://image.tmdb.org/t/p"
    }
}

// MARK: - Operation protocol

protocol APIOperation: AnyObject {
    
    associatedtype Result: Codable
    
    typealias SuccessCallback = (Result) -> Void
    typealias ErrorCallback = (Error) -> Void
    
    var apiPath:String { get }
    
    var completeLink:String { get }
    
    var onSuccess:SuccessCallback? { get set }
    var onError:ErrorCallback? { get set }
    
    func perform()
    func parse(data:Data) -> Result?
}

extension APIOperation {
    
    var baseLink:String {
        return "\(API.link)\(self.apiPath)?api_key=\(API.key)"
    }
}

// MARK: - Get operation protocol

protocol APIGetOperation:APIOperation {
}

extension APIGetOperation {
    
    func perform() {
        guard let resquestURL = URL(string: self.completeLink) else {
            self.onError?(APIError.badURL)
            return
        }
        
        var request = URLRequest(url: resquestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] dta, res, err in
            guard let response = res as? HTTPURLResponse, let data = dta else {
                DispatchQueue.main.async { self?.onError?(APIError.notFound) }
                return
            }
            
            var possibleError:APIError?
            
            switch response.statusCode {
            case 200: possibleError = nil
            case 401: possibleError = APIError.unauthorized
            default : possibleError = APIError.notFound
            }
            
            if let error = possibleError {
                DispatchQueue.main.async { self?.onError?(error) }
                return
            }
            
            guard let parsedResult = self?.parse(data: data) else {
                DispatchQueue.main.async { self?.onError?(APIError.badParsing) }
                return
            }
            
            DispatchQueue.main.async { self?.onSuccess?(parsedResult) }
        }.resume()
    }
}

// MARK: - Parser

final class APIParser<T:Codable> {
    
    func parse(data:Data) -> T? {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            return nil
        }
    }
}

// MARK: - Error

enum APIError: Error {
    case badURL
    case badParsing
    case unauthorized
    case notFound
}
