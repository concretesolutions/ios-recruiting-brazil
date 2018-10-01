//
//  RequestMockProvider.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya
import RxSwift

@testable import ios_recruiting_brazil

final class RequestMockProvider<Target: TargetType>: RequestProtocol {
    
    private let provider: MoyaProvider<Target>
    
    public init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                plugins: [PluginType] = []) {
        
        let endpointClosureWithDefaultHeaders = { (target: Target) -> Endpoint in
            return MoyaProvider.defaultEndpointMapping(for: target)
        }
        self.provider = MoyaProvider(endpointClosure: endpointClosureWithDefaultHeaders)
    }
    
    func requestArray<Model: Mappable>(_ target: Target) -> Observable<[Model]> {
        return self.doRequest(target).flatMap({ response -> Observable<[Model]> in
            return Observable.just(try response.mapModel())
        })
    }
    
    func requestObject<Model: Mappable>(_ target: Target) -> Observable<Model> {
        return self.doRequest(target).flatMap({ response -> Observable<Model> in
            return Observable.just(try response.mapModel())
        })
    }
    
    func requestJSON(_ target: Target) -> Observable<Response> {
        return self.doRequest(target)
    }
    
    private func doRequest(_ target: Target) -> Observable<Response> {
        return Observable.create { observer in
            guard let path = Bundle.main.path(forResource: target.path, ofType: "json") else {
                observer.onError(DataError.statusCode(Response(statusCode: 404, data: Data())))
                observer.onCompleted()
                return Disposables.create()
            }
            
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                observer.onNext(Response(statusCode: 200, data: data))
                observer.onCompleted()
            } catch let error {
                observer.onError(error)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
