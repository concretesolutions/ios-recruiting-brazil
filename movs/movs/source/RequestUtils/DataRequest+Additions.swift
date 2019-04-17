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
        return Observable.create { ob -> Disposable in
            let request = self.responseData(queue: queue, completionHandler: { dataResponse in
                print("Handling result: \(dataResponse)")
                switch dataResponse.result {
                case .success(let value):
                    ob.onNext((value, dataResponse.response))
                    ob.onCompleted()
                case .failure(let error):
                    if case RestError.unknown(_, _) = error {
                        print("Unknown error with response: \(dataResponse.response!)")
                        ob.onError(RestError.from(dataResponse.response!, dataResponse.data))
                    } else {
                        print("Error: \(error)")
                        ob.onError(error)
                    }
                }
            })
            return Disposables.create(with: request.cancel)
        }
    }
    
}
