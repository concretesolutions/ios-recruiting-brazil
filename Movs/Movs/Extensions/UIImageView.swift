//
//  UIImageView.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 06/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(fromURL url: String?) {
        DispatchQueue.main.async {
            self.image = nil
        }

        guard let url = url else {
            return
        }

        let dataTask = URLSession.shared.dataTask(with: URL(string: url)!) { (data, _, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }

        dataTask.resume()
    }
}
