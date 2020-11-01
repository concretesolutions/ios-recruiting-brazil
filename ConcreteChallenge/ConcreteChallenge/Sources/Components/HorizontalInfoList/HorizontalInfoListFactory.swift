//
//  HorizontalInfoListFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 31/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum HorizontalInfoListFactory {
    static func makeItem() -> HorizontalInfoListItemView {
        let viewModel = HorizontalInfoListViewModel(imageURL: "https://ingresso-a.akamaihd.net/img/cinema/cartaz/22968-cartaz.jpg", title: "Sonic", subtitle: "2019", descriptionText: "Sonic é bacana")
        let item = HorizontalInfoListItemView(viewModel: viewModel)

        return item
    }
}
