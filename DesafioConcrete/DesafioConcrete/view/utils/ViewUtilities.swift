//
//  ViewUtilities.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: String, callback: @escaping () -> ()) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL(string: url)!) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        callback()
                    }
                } else {
                    print("Imagem não encontrada")
                    callback()
                }
            }else {
                print("Data não recuperada")
                callback()
            }
        }
    }
}
