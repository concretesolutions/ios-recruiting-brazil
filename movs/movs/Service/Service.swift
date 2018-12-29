//
//  Service.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import Foundation

final class Service {
    // MARK: - Singleton
    static let shared = Service()
    private init() {}
}

// MARK: - Public
extension Service {
    func retrieveData(endpoint: String,
                      completion: @escaping (Data) -> Void,
                      error: @escaping () -> Void) {
        let urlString = Constants.Integration.baseurl + endpoint + Constants.Integration.apikey

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, errorObject in
            guard errorObject == nil,
                let usableData = data else {
                    DispatchQueue.main.async {
                        error()
                    }

                    return
            }

            DispatchQueue.main.async {
                completion(usableData)
            }
        }

        task.resume()
    }
}
