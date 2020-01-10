//
//  TableViewDataSource.swift
//  ConcreteChallenge
//
//  Created by Marcos Santos on 22/12/19.
//  Copyright © 2019 Marcos Santos. All rights reserved.
//

import UIKit

class TableViewDataSource<C: Cell & UITableViewCell>: NSObject, UITableViewDataSource {
    var viewModels: [C.ViewModelType]

    init(viewModels: [C.ViewModelType]) {
        self.viewModels = viewModels
    }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(C.self, for: indexPath)
            .set(\.viewModel, to: viewModels[indexPath.row])
    }
}
