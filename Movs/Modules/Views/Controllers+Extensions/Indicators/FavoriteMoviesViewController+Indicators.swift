//
//  FavoriteMoviesViewController+Indicators.swift
//  Movs
//
//  Created by Gabriel D'Luca on 18/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - ErrorIndicator

extension FavoriteMoviesViewController: ErrorIndicator {
    func showSearchError() {
        self.displayedError = .searchError
        self.errorScreen.retryButton.isHidden = true
        self.errorScreen.titleLabel.text = "Nothing to see here!"
        self.errorScreen.descriptionLabel.text = "Sorry, we didn't find any results matching your search."
        self.errorScreen.errorIcon.image = UIImage(systemName: "magnifyingglass")
        self.view = self.errorScreen
    }
}
