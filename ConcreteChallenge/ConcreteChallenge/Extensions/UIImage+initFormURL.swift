//
//  UIImage+initFormURL.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// fetch a image from url
    ///
    /// - Parameter url: the url of the target image
    /// - Throws: data conversion error
    convenience public init?(url: URL) throws {
        let data = try Data.init(contentsOf: url)
        self.init(data: data)
    }
}
