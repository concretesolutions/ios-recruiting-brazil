//
//  CodableEncoding.swift
//  Headlines
//
//  Created by Lorien Moisyn on 14/03/19.
//  Copyright © 2019 Lorien Moisyn. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

public protocol CodableEncoding {
    
    func encode<T>(_ urlRequest: Alamofire.URLRequestConvertible, with encodable: T?) throws -> URLRequest where T : Encodable
    
}

public extension CodableEncoding {
    
    func encode<T>(_ urlRequest: Alamofire.URLRequestConvertible, with encodable: T?) -> Observable<URLRequest> where T : Encodable {
        return Observable.create { ob -> Disposable in
            do {
                ob.onNext(try self.encode(urlRequest, with: encodable))
                ob.onCompleted()
            } catch {
                ob.onError(error)
            }
            return Disposables.create()
        }
    }
    
}

extension URLEncoding: CodableEncoding {
    
    public func encode<T>(_ urlRequest: Alamofire.URLRequestConvertible, with encodable: T?) throws -> URLRequest where T : Encodable {
        return try self.encode(urlRequest, with: try encodable?.asDictionary())
    }
    
}

extension Encodable {
    
    func asDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
    
}
