//
//  ListCheckTableViewFactory.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum ListCheckTableViewFactory {
    static func makeTableView() -> ListCheckItemView {
        let viewModel = ListCheckItemViewModel(title: "Date", value: "2008", icon: .arrowForward)
        let listCheckItem = ListCheckItemView(viewModel: viewModel)

        return listCheckItem
    }
}
