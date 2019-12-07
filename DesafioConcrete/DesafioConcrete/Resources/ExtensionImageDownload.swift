//
//  ExtensionImageDownload.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 05/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from link: String, contentMode mode: UIView.ContentMode) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(link)") else { return }
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
}
