//
//  ResponseData.swift
//  Headlines
//
//  Created by Lorien Moisyn on 15/03/19.
//  Copyright © 2019 Lorien Moisyn. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

public extension Alamofire.DataRequest {
    
    typealias AlamoDataPromisse = (Data?, HTTPURLResponse?)
    
    // Adds a handler to be called once the request has finished.
    public func responseData(queue: DispatchQueue? = nil) -> Observable<AlamoDataPromisse> {
        return Observable.create { observable -> Disposable in
            let request = self.responseData(queue: queue, completionHandler: { dataResponse in
                print("Handling result: \(dataResponse)")
                switch dataResponse.result {
                case .success(let value):
                    observable.onNext((value, dataResponse.response))
                    observable.onCompleted()
                case .failure(let error):
                    observable.onError(error)
                }
            })
            return Disposables.create(with: request.cancel)
        }
    }
    
}
