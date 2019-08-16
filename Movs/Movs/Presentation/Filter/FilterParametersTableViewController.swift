//
//  FilterParametersTableViewController.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import UIKit

public protocol FilterDelegate: AnyObject {
    func updateParameter(for option: FilterOptions, with value: String)
    func updateMovies(with filteredMovies: [Movie])
}

public extension FilterDelegate {
    func updateParameter(for option: FilterOptions, with value: String) {}
    func updateMovies(with filteredMovies: [Movie]) {}
}

class FilterParametersTableViewController: UITableViewController {

    var parameters: [String] = []
    //swiftlint:disable weak_delegate
    var delegate: FilterDelegate?
    var option: FilterOptions!
    var selectedParameter: String!

    init(parameters: [String], option: FilterOptions, style: UITableView.Style, delegate: FilterDelegate, selectedParameter: String) {
        self.parameters = parameters
        self.option = option
        self.delegate = delegate
        self.selectedParameter = selectedParameter
        super.init(style: style)
        self.title = option.localized()
        self.tableView.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellType: FilterTableViewCell.self)
    }

    // MARK: - TableView DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.parameters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var isSelected = false
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
        if selectedParameter == parameters[indexPath.row] {
            isSelected = true
        }
        cell.setupParameter(with: parameters[indexPath.row], isSelecetd: isSelected)
        return cell
    }

    // MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.updateParameter(for: self.option, with: parameters[indexPath.row])
        self.navigationController?.popViewController(animated: true)
    }
}
