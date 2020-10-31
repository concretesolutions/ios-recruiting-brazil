//
//  InfoListTableViewFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum InfoListTableViewFactory {
    static func makeTableView(movie: Movie) -> InfoListTableView {
        let icon: UIImage.Assets = movie.isFavorite ? .favoriteFullIcon : .favoriteEmptyIcon

        let joinedGenre = movie.genreLabels.count > 0 ? movie.genreLabels.joined(separator: Constants.MoviesDetails.genresSeparator) : nil

        let InfoListItemsViewModel = [
            InfoListItemViewModel(title: movie.title, icon: icon),
            InfoListItemViewModel(title: movie.releaseDate.year),
            InfoListItemViewModel(title: joinedGenre),
            InfoListItemViewModel(descriptionText: movie.overview)
        ].filter { infoListItemViewModel in
            infoListItemViewModel.title != nil || infoListItemViewModel.icon != nil || infoListItemViewModel.descriptionText != nil
        }

        let tablewView = InfoListTableView(infos: InfoListItemsViewModel)

        return tablewView
    }
}
