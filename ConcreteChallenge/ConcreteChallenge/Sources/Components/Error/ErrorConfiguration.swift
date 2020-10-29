//
//  ErrorConfiguration.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 28/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct ErrorConfiguration: Equatable {
    var image: UIImage
    var text: String

    public init(image: UIImage? = nil, text: String? = nil) {
        let imageError = UIImage(assets: .error) ?? UIImage()

        self.image = image ?? imageError
        self.text = text ?? Strings.errorFetch.localizable
    }
}
