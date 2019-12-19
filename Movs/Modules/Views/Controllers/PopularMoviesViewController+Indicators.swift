//
//  PopularMoviesViewController+Indicators.swift
//  Movs
//
//  Created by Gabriel D'Luca on 17/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

// MARK: - LoadingIndicator

extension PopularMoviesViewController {
    func showLoadingIndicator() {
        self.screen.loadingIndicatorView.isHidden = false
        self.screen.loadingIndicatorView.indicatorView.startAnimating()
        UIView.animate(withDuration: 0.15, animations: {
            self.screen.loadingIndicatorView.alpha = 1.0
        })
    }
    
    func hideLoadingIndicator() {
        self.screen.loadingIndicatorView.indicatorView.stopAnimating()
        UIView.animate(withDuration: 0.15, animations: {
            self.screen.loadingIndicatorView.alpha = 0.0
        }, completion: { _ in
            self.screen.loadingIndicatorView.isHidden = true
        })
    }
}

// MARK: - ErrorIndicator

extension PopularMoviesViewController: ErrorIndicator {
    func showNetworkError() {
        self.displayedError = self.displayedError == .searchError ? .searchAndNetworkError : .networkError
        self.errorScreen.retryButton.isHidden = false
        self.errorScreen.descriptionLabel.text = "Something went wrong. Please, try again."
        self.errorScreen.errorIcon.image = UIImage(systemName: "wifi.exclamationmark")
        self.view = self.errorScreen
    }
    
    func showSearchError() {
        self.displayedError = self.displayedError == .networkError ? .searchAndNetworkError : .searchError
        self.errorScreen.retryButton.isHidden = true
        self.errorScreen.descriptionLabel.text = "Sorry, we didn't find any results matching your search."
        self.errorScreen.errorIcon.image = UIImage(systemName: "magnifyingglass")
        self.view = self.errorScreen
    }
    
    @objc func retryConnection(_ sender: UIButton) {
        self.displayedError = self.displayedError == .searchAndNetworkError ? .searchError : .none
        self.view = self.screen
        
        if self.viewModel.shouldFetchGenres {
            self.viewModel.fetchGenresList()
        } else if self.viewModel.shouldFetchNextPage {
            self.viewModel.fetchNextPopularMoviesPage()
        }
    }
}
