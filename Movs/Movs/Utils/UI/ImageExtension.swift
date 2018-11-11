//
//  Image.swift
//  Movs
//
//  Created by João Gabriel Borelli Padilha on 11/11/18.
//  Copyright © 2018 João Gabriel Borelli Padilha. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadMovieImage(urlString: String, to: MovieCollectionViewCell, completion: @escaping (_:Bool)->() ) {
        
        self.loadImage(imageURL: urlString) { (loadingImage) in
            // Loading Image First
            if let downloadedImage = loadingImage {
                // Verificar
                if to.imageURL != urlString {
                    //print("WRONG")
                    completion(false)
                    return
                }else{
                    self.image = downloadedImage
                    completion(true)
                }
                
            }
        }
        
    }
    
    func loadImage(imageURL:String, completion: @escaping (_:UIImage?)->()) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            DispatchQueue.main.async  {
                if let downloadedImage = UIImage(data: data!) {
                    completion(downloadedImage)
                }
            }
        }.resume()
    }
    
}
