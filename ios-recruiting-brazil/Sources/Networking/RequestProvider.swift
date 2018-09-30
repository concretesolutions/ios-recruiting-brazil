//
//  RequestProvider.swift
//  ios-recruiting-brazil
//
//  Created by André Vieira on 30/09/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Mapper
import Moya
import RxSwift

final class RequestProvider<Target: TargetType>: RequestProtocol {
    
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
            let cancellableToken = self.provider.request(target) { result in
                do {
                    let response = try result.dematerialize().filterSuccessfulStatusCodes()
                    observer.onNext(response)
                    observer.onCompleted()
                } catch let error as MoyaError {
                    observer.onError(DataError.fromMoya(error))
                } catch {
                    observer.onError(DataError.underlying(error))
                }
            }
            return Disposables.create {
                cancellableToken.cancel()
            }
        }
    }
}
