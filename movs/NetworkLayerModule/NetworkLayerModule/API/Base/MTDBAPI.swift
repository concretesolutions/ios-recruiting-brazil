//
//  MTDBAPI.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public typealias APIHeaders = [String : Any]

public enum MtdbAPIError: Error {
    case unexpected(Error)
    case baseUrlInvalid
    case badRequest
    case jsonDecoded
    case emptyData
    case invalidToken
}

public protocol MtdbAPI  {
    var token: String { get }
    var method: HTTPMethodAPI { get }
    var path: String { get }
    var baseUrl: String { get }
    var headers: APIHeaders { get }
    var language: String { get }
    var timeOut: TimeInterval { get }
    var cachePolicy: URLRequest.CachePolicy { get }
}

extension MtdbAPI {
    
    public var cachePolicy: URLRequest.CachePolicy {
        return URLRequest.CachePolicy.reloadRevalidatingCacheData
    }
    
    public var absoluteURL: URL {        
        var urlFull = self.baseUrl + self.path
        urlFull = urlFull.replacingOccurrences(of: "\\", with: "", options: NSString.CompareOptions.literal, range: nil)
        return URL(string: urlFull)!
    }
    
    public var token: String {
        let result: String = ReaderInfoPlist.value(for: InfoPListValues.API.key)
        return result
    }
    
    public var timeOut: TimeInterval {
        return 20
    }
    
    public var method: HTTPMethodAPI {
        return .get
    }
    public var headers: APIHeaders {
        return APIHeaders()
    }
    
    public var language: String {
        return "en-US"
    }
    
    public var baseUrl: String {
        let result: String = ReaderInfoPlist.value(for: InfoPListValues.API.domain)
        return result
    }
}
