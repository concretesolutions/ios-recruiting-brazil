//
//  Image.swift
//  Movs
//
//  Created by Joao Lucas on 09/10/20.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlImage: String) {
        let url = URLRequest(url: URL(string: urlImage)!)
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if error != nil {
                print("Erro ao carregar imagem")
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
}
