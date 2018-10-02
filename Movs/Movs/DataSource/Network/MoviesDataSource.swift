//
//  MoviesDataSource.swift
//  Movs
//
//  Created by Dielson Sales on 01/10/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit
import RxSwift

/**
 The basic set of methods that any implementation must comform to.
 */
protocol MoviesDataSource {
    func fetchPopularMovies() -> Single<[Movie]>
}

/**
 The default implementation of MoviesDataSource used in the project.
 */
class MoviesDataSourceImpl: MoviesDataSource {

    private func fetchData(url: URL) -> Single<Data> {
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

    func fetchPopularMovies() -> Single<[Movie]> {
        let url: URL! = URL(string: "http://api.themoviedb.org/3/movie/popular?api_key=f1ee15e95c330dccd34b6fdd63de841d")
        return fetchData(url: url).map({ (data: Data) -> [Movie] in
            return [Movie(), Movie()]
        })
    }
}
