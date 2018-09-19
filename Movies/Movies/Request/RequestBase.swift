//
//  RequestBase.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import Foundation
import Alamofire

// Class responsible for all the requests performed inside the app
class RequestBase {
    
    /// 
    var parameters:[String:Any] = [:]
    
    /// The App Access key
    private let apiKey = "954394990cb9c14c975548df90254c44"
    
    private static let session: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        configuration.httpCookieStorage = HTTPCookieStorage.shared
        return SessionManager(configuration: configuration)
    }()
    
    /// The name of the Endpoint
    private var endpointName = ""
    
    /// Returns the Base URL, according to the development environment (Debug or Release)
    private var BASE_URL:String {
        return Bundle.main.infoDictionary?["BASE_URL"] as? String ?? ""
    }
    
    /// The request URL
    private var defaultURL:String{
        get{
            if let path = Bundle.main.path(forResource: "Endpoints", ofType: "plist") {
                if let plist = NSDictionary(contentsOfFile: path), let endpoint = plist[endpointName] as? String {
                    return BASE_URL + endpoint
                }
                else{
                    fatalError("The endpoint named ''\(endpointName)'' does not exist")
                }
            }
            else{
                fatalError("The file ''endpoints'' could not be located")
            }
        }
    }
    
    init() {
        parameters["api_key"] = apiKey
    }
    
    func get(endpoint:Endpoint, parameters: Parameters?=nil) -> DataRequest {
        endpointName = endpoint.rawValue
        printAccess(parameters)
        return RequestBase.session.request(defaultURL, method: .get, parameters: parameters, headers:nil)
    }
    
    func get(endpoint: Endpoint, movieId: Int) -> DataRequest {
        endpointName = endpoint.rawValue
        printAccess(["movie id":movieId])
        return RequestBase.session.request("\(defaultURL)\(movieId)", method: .get, parameters: parameters, headers:nil)
    }
    
    // Request logs
    private func printAccess(_ parameters: Parameters?){
        let param: Any = parameters ?? "--"
        print("\n ======== URL SENDO ACESSADA ======== \n\n - URL:\n \(defaultURL) \n\n - PARAMETROS:\n \(param)\n ==================================== \n")
    }
}

enum Endpoint:String {
    
    /// Endpoint for the list of movies
    case movies
    
    /// Endpoint for the detail of o movie
    case detail
}
