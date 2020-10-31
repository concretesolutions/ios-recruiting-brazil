//
//  TableViewDataSource.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 30/10/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class TableViewDataSource<M, C>: DataSource<M>, UITableViewDataSource where C: UITableViewCell {
    typealias CellConfigurator = (M, C) -> Void

    // MARK: - Private constants

    private let cellConfigurator: CellConfigurator

    // MARK: - Initializers

    init(models: [M] = [], cellConfigurator: @escaping CellConfigurator) {
        self.cellConfigurator = cellConfigurator

        super.init(models: models)
    }

    // MARK: - UICollectionViewDataSource conforms

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: C.className, for: indexPath)

        if let cell = cell as? C {
            let model = get(at: indexPath.row)
            cellConfigurator(model, cell)
        }

        return cell
    }
}
