//
//  FilterListScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 27/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

protocol FilterListScreenDelegate: class {
    func appliedFilters()
}

final class FilterListScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var filtersTableView: UITableView!

    // MARK: - Properties
    private var filters = [FilterSegue]()

    // MARK: - Delegate
    weak var delegate: FilterListScreenDelegate?

    struct FilterSegue {
        let name: String
        let segueId: String
        let selected: String
    }
}

// MARK: - Lifecycle
extension FilterListScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == filters[0].segueId {
            guard let screen = segue.destination as? FilterDateScreen else { return }
            screen.delegate = self
        } else if segue.identifier == filters[1].segueId {
            guard let screen = segue.destination as? FilterGenresScreen else { return }
            screen.delegate = self
        }
    }
}

// MARK: - Private
extension FilterListScreen {
    private func setupUI() {
		filtersTableView.tableFooterView = UIView()
        filtersTableView.register(FilterListCell.self)

        filters = [FilterSegue(name: "Date", segueId: "filterDateSegue", selected: ""),
                   FilterSegue(name: "Genres", segueId: "filterGenresSegue", selected: "")]
    }
}

// MARK: - UITableViewDataSource
extension FilterListScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FilterListCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.setup(title: filters[indexPath.row].name, filter: "")
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FilterListScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: filters[indexPath.row].segueId,
                     sender: nil)
    }
}

// MARK: - IBActions
extension FilterListScreen {
    @IBAction private func tappedApplyFilters(_ sender: Any) {
        delegate?.appliedFilters()
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - FilterDateScreenDelegate
extension FilterListScreen: FilterDateScreenDelegate {
    func didSelectDate(_ dateString: String) {

    }
}

// MARK: - FilterGenresScreenDelegate
extension FilterListScreen: FilterGenresScreenDelegate {
    func didSelectGenre(_ genre: Genre) {

    }
}
