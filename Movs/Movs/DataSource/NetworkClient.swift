//
//  NetworkClient.swift
//  Movs
//
//  Created by Dielson Sales on 02/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

enum NetworkClientConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let allowedMimeTypes = ["application/json", "image/jpeg"]
    static let apiKey = "f1ee15e95c330dccd34b6fdd63de841d"
}

func requestData(url: String) -> Single<Data> {
    guard let url = URL(string: "\(url)?api_key=\(NetworkClientConstants.apiKey)") else {
        return Single.error(MovErrors.genericError)
    }
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
            if let mimeType = httpResponse.mimeType,
                NetworkClientConstants.allowedMimeTypes.contains(mimeType),
                let data = data {
                DispatchQueue.main.async {
                    observer(.success(data))
                }
            }
        }
        task.resume()
        return disposable
    }
}

func parseDecodable<T: Decodable>(from data: Data) -> T? {
    do {
        let object = try JSONDecoder().decode(T.self, from: data)
        return object
    } catch {
        return nil
    }
}
