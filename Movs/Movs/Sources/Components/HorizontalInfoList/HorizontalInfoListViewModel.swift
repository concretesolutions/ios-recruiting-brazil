//
//  HorizontalInfoListViewModel.swift
//  Movs
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct HorizontalInfoListViewModel {
    var imageURL: String
    var title: String
    var subtitle: String
    var descriptionText: String

    // MARK: - Initializers

    init(imageURL: String, title: String, subtitle: String, descriptionText: String) {
        self.imageURL = imageURL
        self.title = title
        self.subtitle = subtitle
        self.descriptionText = descriptionText
    }
}
