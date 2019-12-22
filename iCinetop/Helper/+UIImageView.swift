//
//  +UIImage.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
extension UIImageView {
    func load(url: URL, completion: @escaping ((_ errorMessage: String?) -> Void)) {
        DispatchQueue.global().async { //[weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                        completion(nil)
                    }
                }
            }
        }
    }
}
