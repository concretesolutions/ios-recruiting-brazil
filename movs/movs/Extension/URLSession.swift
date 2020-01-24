//
//  URLSession.swift
//  movs
//
//  Created by Isaac Douglas on 23/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import UIKit

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? JSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func popularTask(with url: URL, completionHandler: @escaping (Popular?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func genresTask(with url: URL, completionHandler: @escaping (Genres?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
    
    func imageTask(with url: URL, completionHandler: @escaping (UIImage?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(image, response, nil)
        }
    }
}
