//
//  ListCheckItemViewModel.swift
//  Movs
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct ListCheckItemViewModel {
    var title: String?
    var value: String?
    var icon: UIImage.Assets?

    // MARK: - Initializers

    init(title: String? = nil, value: String? = nil, icon: UIImage.Assets? = nil) {
        self.title = title
        self.value = value
        self.icon = icon
    }
}
