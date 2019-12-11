//
//  UIImageView+URL.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 11/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit
extension UIImage {

    /// fetch a image from url
    ///
    /// - Parameter url: the url of the target image
    /// - Throws: data conversion error
    convenience public init?(url: URL) {
        if let data = try? Data.init(contentsOf: url) {
            self.init(data: data)
        } else {
            return nil
        }
    }

}

extension UIImageView {
    func setImage(withURL url: String) {
        let apiProvider = APIProvider<Movie>()
        apiProvider.requestImage(withURL: url) { result in
            switch result {
            case .success(let data):
                self.image = UIImage(data: data)
            case .failure: break
            }
        }
    }
}
