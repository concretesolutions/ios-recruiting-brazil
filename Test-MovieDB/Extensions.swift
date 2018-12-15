//
//  Extensions.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 13/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

//MARK: - EXTENSIONS UIIMAGEVIEW

extension UIImageView {
    
    //MARK: - METHODS
    
    func loadImageFromURLString(urlStirng: String?) {
        
        guard let imageString = urlStirng else { return }
        
        let url = "http://image.tmdb.org/t/p/w185/\(imageString)"
        
        guard let urlOfPhoto = URL(string: url) else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: urlOfPhoto) { (data, response, error) in
            if error == nil {
                guard let response = response as? HTTPURLResponse else {
                    return
                }
                if response.statusCode == 200 {
                    guard let data = data else { return }
                    
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        self.isHidden = false
                    }
                }
            }
        }
        dataTask.resume()
    }
}

extension Notification.Name {
    static let didReceiveData = Notification.Name("didReceiveData")
    static let reloadTable = Notification.Name("reloadCollection")
}
