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

protocol APIOperation {
    
    associatedtype Result: Codable
    
    typealias SuccessCallback = (Result) -> Void
    typealias ErrorCallback = (Error) -> Void
    
    var apiPath:String { get }
    var parser:APIParser<Result> { get }
    
    var onSuccess:SuccessCallback? { get set }
    var onError:ErrorCallback? { get set }
    
    func perform()
}

extension APIOperation {
    
    var baseLink:String {
        return "\(API.link)\(self.apiPath)?api_key=\(API.key)"
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
