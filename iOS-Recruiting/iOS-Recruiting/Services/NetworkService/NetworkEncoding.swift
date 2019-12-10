//
//  NetworkEncoding.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import Foundation

extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}

public protocol NetworkEncodingDelegate {
    func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?)  -> URLRequest
}

public struct NetworkEncoding: NetworkEncodingDelegate {
    
    public func encode(_ urlRequest: URLRequest, with parameters: [String: Any]?)  -> URLRequest {
        var urlRequest = urlRequest
        
        guard let url = urlRequest.url,
            let httpMethod = urlRequest.httpMethod,
            let method = HTTPMethod(rawValue: httpMethod),
            let parameters = parameters, !parameters.isEmpty else {
            return urlRequest
        }
        
        let inURL = self.encodesParametersInURL(with: method)
        let isValidJSON = JSONSerialization.isValidJSONObject(parameters)
        
        switch (inURL, isValidJSON) {
        case (true, _):
            let content = "application/json; charset=utf-8"
            urlRequest.setValue(content, forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(content, forHTTPHeaderField: "Accept")
            urlRequest.url = self.encodedQueryFrom(url: url, parameters: parameters)
        case (_, true):
            let content = "application/json; charset=utf-8"
            urlRequest.setValue(content, forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(content, forHTTPHeaderField: "Accept")
            urlRequest.httpBody = self.JSONSerializationFrom(parameters: parameters)
        default:
            let content = "application/x-www-form-urlencoded; charset=utf-8"
            urlRequest.setValue(content, forHTTPHeaderField: "Content-Type")
            urlRequest.setValue(content, forHTTPHeaderField: "Accept")
            urlRequest.httpBody = query(parameters).data(using: .utf8, allowLossyConversion: false)
        }
        
        return urlRequest
    }
    
    private func encodedQueryFrom(url: URL, parameters: [String: Any]) -> URL? {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let query = urlComponents.percentEncodedQuery.map { $0 + "&" } ?? ""
        let encoded = query + self.query(parameters)
        urlComponents.percentEncodedQuery = encoded
        
        return urlComponents.url
    }
    
    private func JSONSerializationFrom(parameters: [String: Any]) -> Data? {
        do {
            let json = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            return json
        } catch {
            Log.shared.show(error: error.localizedDescription)
            return nil
        }
    }
    
    private func query(_ parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        
        for key in parameters.keys.sorted(by: <) {
            let value = parameters[key]!
            components += queryComponents(fromKey: key, value: value)
        }
        
        return components.map { "\($0)=\($1)" }.joined(separator: "&")
    }

    private func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += queryComponents(fromKey: "\(key)[]", value: value)
            }
        } else if let value = value as? NSNumber {
            if value.isBool {
                components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
            } else {
                components.append((escape(key), escape("\(value)")))
            }
        } else if let bool = value as? Bool {
            components.append((escape(key), escape((bool ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
        
        return components
    }
    
    private func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
    
    private func encodesParametersInURL(with method: HTTPMethod) -> Bool {
        switch method {
        case .get, .head, .delete:
            return true
        default:
            return false
        }
    }
    
}
