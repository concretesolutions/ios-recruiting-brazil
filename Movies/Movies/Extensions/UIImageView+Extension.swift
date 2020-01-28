//
//  UIImageView+Extension.swift
//  Muv Concrete
//
//  Created by Mariaelena Silveira on 16/01/20.
//  Copyright © 2020 Mariaelena Silveira. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }

            DispatchQueue.main.async() {
                self.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        let correctUrl = "http://image.tmdb.org/t/p/w154/" + link
        guard let url = URL(string: correctUrl) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
