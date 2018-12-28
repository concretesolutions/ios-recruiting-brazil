//
//  Service.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 26/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import Alamofire

final class Service {
    // MARK: - Singleton
    static let shared = Service()
    private init() {}
}

// MARK: - Public
extension Service {
    func retrieveData(endpoint: String,
                      completion: @escaping (Data) -> Void) {
        let urlString = Constants.Integration.baseurl + endpoint + Constants.Integration.apikey

        guard let url = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil,
                let usableData = data else {
                    return
            }

            DispatchQueue.main.async {
                completion(usableData)
            }
        }

        task.resume()
    }
}
