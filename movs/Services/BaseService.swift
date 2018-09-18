//
//  BaseService.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import Alamofire

enum HTTPResponseCode: Int {
    case disconnected = 0
    case timeOutSec = 60
    case success = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case notFound = 404
    case timeOut = 408
    case unprocessableEntity = 422
    case internalServerError = 500
    case badGateway = 502
}

let kDomainDefault: String = Bundle.main.object(forInfoDictionaryKey: "BUNDLE_ID") as? String ?? ""

class BaseService {
    let apiKey = "8475d0a16fe6bf503da7a300cb11e63f"
    
    enum BaseURL: String {
        case server = "https://api.themoviedb.org/3/"
        case image = "https://image.tmdb.org/t/p/w300"
    }
    
    func serviceResponse(method: HTTPMethod, baseURL: BaseURL, path: String, parameters: [String: Any]? = nil, headers: [String: String]? = nil, completion: @escaping (_ code: Int?, _ result: AnyObject?, _ error: NSError?, _ meta: Meta?) -> Void) {
        let headers: [String: String] = headers ?? [:]
        let encoded = (baseURL.rawValue + path).addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        self.consoleHTTPRequest(url: encoded ?? "", parameters: parameters, headers: headers)
        Alamofire.request(encoded ?? "", method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            switch response.result {
            case .success(let jsonData):
                let entries = jsonData as AnyObject?
                self.consoleHTTPResponse(code: response.response?.statusCode, json: entries)
                var meta: Meta?
                if let metaData = entries as? NSDictionary {
                    meta = Meta(fromDictionary: metaData)
                }
                completion(response.response?.statusCode, entries, nil, meta)
            case .failure(let error):
                if let code: Int = response.response?.statusCode {
                    completion(code, nil, error as NSError?, nil)
                    return
                }
                
                completion(HTTPResponseCode.disconnected.rawValue, nil, error as NSError?, nil)
            }
        }
    }
    
    func generateError(code: Int, result _result: AnyObject?, error _error: NSError?) -> NSError {
        switch code {
        case HTTPResponseCode.disconnected.rawValue:
            let error: NSError = NSError(domain: kDomainDefault, code: HTTPResponseCode.disconnected.rawValue, userInfo: [NSLocalizedDescriptionKey: "A conexão com a Internet parece estar offline."])
            self.consoleHTTPError(error: error)
            return error
            
        case HTTPResponseCode.unprocessableEntity.rawValue:
            if let result: NSArray = _result?["errors"] as? NSArray {
                for dataError: NSDictionary in result as! [NSDictionary] {
                    let error: NSError = NSError(domain: kDomainDefault, code: dataError["code"] as? Int ?? 0, userInfo: [NSLocalizedDescriptionKey: dataError["message"] as? String ?? ""])
                    self.consoleHTTPError(error: error)
                    return error
                }
            }
            
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: "Error code: \(String(describing: _error))"])
            self.consoleHTTPError(error: error)
            return error
            
        case HTTPResponseCode.unauthorized.rawValue:
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: ""])
            return error
        case HTTPResponseCode.forbidden.rawValue:
            if let result: NSArray = _result?["errors"] as? NSArray {
                for dataError: NSDictionary in result as! [NSDictionary] {
                    let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: dataError["message"] as? String ?? ""])
                    self.consoleHTTPError(error: error)
                    return error
                }
            }
            
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: "Error code: \(String(describing: _error))"])
            self.consoleHTTPError(error: error)
            return error
            
        case HTTPResponseCode.badGateway.rawValue:
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: "Ocorreu algum problema. Por favor, tente mais tarde."])
            self.consoleHTTPError(error: error)
            return error
            
        case HTTPResponseCode.internalServerError.rawValue:
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: "Aconteceu um erro inesperado, tente novamente mais tarde."])
            self.consoleHTTPError(error: error)
            return error
            
        default:
            let error: NSError = NSError(domain: kDomainDefault, code: code, userInfo: [NSLocalizedDescriptionKey: "Aconteceu um erro inesperado, tente novamente mais tarde."])
            self.consoleHTTPError(error: error)
            return error
            
        }
    }
}


extension BaseService {
    fileprivate func consoleHTTPRequest(url: String, parameters: Any?, headers: Any?) {
        print("\n\n------------------------------------------------------------")
        print("URL: \(url) \n")
        if let headers = headers {
            print("Headers: \(headers) \n")
        } else {
            print("Headers: nil \n")
        }
        if let parameters = parameters {
            print("Parameters: \(parameters) \n")
        } else {
            print("Parameters: nil \n")
        }
        print("------------------------------------------------------------\n\n")
    }
    
    fileprivate func consoleHTTPResponse(code: Int?, json: AnyObject?) {
        print("\n\n------------------------------------------------------------")
        if let code = code {
            print("statusCode: \(code) \n")
        } else {
            print("statusCode: nil \n")
        }
        
        print("JSON: \(json)")
        print("------------------------------------------------------------\n\n")
    }
    
    fileprivate func consoleHTTPError(error: NSError) {
        print("\n\n------------------------------------------------------------")
        print("ERROR:  \(error) \n")
        print("------------------------------------------------------------\n\n")
    }
    
}

extension BaseService {
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}
