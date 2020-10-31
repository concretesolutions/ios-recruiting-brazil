//
//  InfoListItemViewModel.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

struct InfoListItemViewModel {
    var title: String?
    var icon: UIImage.Assets?
    var descriptionText: String?
    var action: (() -> Void)?

    // MARK: - Initializers

    init(title: String? = nil, icon: UIImage.Assets? = nil, descriptionText: String? = nil, action: (() -> Void)? = nil) {
        self.title = title
        self.icon = icon
        self.descriptionText = descriptionText
        self.action = action
    }

    // MARK: - Computed variables

    var isEmpty: Bool {
        return title == nil && icon == nil && descriptionText == nil
    }
}
