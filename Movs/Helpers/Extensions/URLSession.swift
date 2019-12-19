//
//  URLSession.swift
//  Movs
//
//  Created by Gabriel D'Luca on 03/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import Foundation

extension URLSession: NetworkSession {
    func getData(from urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            fatalError("Failed to create URL object from: \(urlString)")
        }
        
        let dataTask = self.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            completion(data, error)
        })
        dataTask.resume()
    }
}
