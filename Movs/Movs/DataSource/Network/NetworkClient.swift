//
//  NetworkClient.swift
//  Movs
//
//  Created by Dielson Sales on 02/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

func requestData(url: URL) -> Single<Data> {
    return Single<Data>.create { observer in
        let disposable = Disposables.create {}
        let task = URLSession.shared.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            guard !disposable.isDisposed else { return }
            if let error = error {
                DispatchQueue.main.async {
                    observer(.error(error))
                }
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    observer(.error(MovErrors.genericError))
                }
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json", let data = data {
                DispatchQueue.main.async {
                    observer(.success(data))
                }
            }
        }
        task.resume()
        return disposable
    }
}
