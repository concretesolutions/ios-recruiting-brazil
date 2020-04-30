//
//  FilterTableViewController.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 28/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController {

    var filters: FavoriteFilters!
    var genres: [Genre]!

    var genresOptions: [String]!
    var yearsOptions: [String]!

    var cancelButon: UIBarButtonItem!
    var applyButton: UIBarButtonItem!

    fileprivate let cellIdentifier = "FilterItemTableViewCell"
    fileprivate let cellButtonIdentifier = "ButtonsTableViewCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView.init(frame: CGRect.zero, style: .grouped)
        self.tableView!.register(UINib(nibName: "FilterItemTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.tableView!.register(UINib(nibName: "ButtonsTableViewCell", bundle: nil), forCellReuseIdentifier: cellButtonIdentifier)

        setupNavigationBar()
    }

    fileprivate func setupNavigationBar() {
        guard let navigationController = self.navigationController else { return }

        let bgColor = UIColor(asset: .brand)

        navigationController.navigationBar.barTintColor = bgColor
        navigationController.view.backgroundColor = bgColor

        navigationController.navigationBar.tintColor = .darkGray

        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = false
        }

        self.cancelButon = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        self.navigationItem.leftBarButtonItem = self.cancelButon

        self.applyButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(applyAction))
        self.navigationItem.rightBarButtonItem = self.applyButton

    }

    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }

    @objc func applyAction() {
        self.filters.appyFilters()
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 2 {

            let buttonCell = tableView.dequeueReusableCell(withIdentifier: cellButtonIdentifier, for: indexPath) as! ButtonsTableViewCell
            buttonCell.setup(title: "Limpar filtro") { [unowned self] _ in
                do {
                    let filters = try self.filters.clone()
                    filters.clear()
                    self.dismiss(animated: true, completion: nil)
                } catch {
                    print("Error cloning filters \(error)")
                }
            }
            return buttonCell

        } else {

            let filterCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FilterItemTableViewCell

            filterCell.delegate = self

            if indexPath.section == 0 {
                let value = filters.year != nil ? "\(filters.year!)" : yearsOptions[0]
                filterCell.setup(title: "Lançados em:", value: value, options: yearsOptions, as: "releaseDate")
            } else {
                filterCell.setup(title: "Gênero: ", value: filters.genre?.name ?? genresOptions[0], options: genresOptions, as: "genre")
            }

            return filterCell

        }
    }
}

extension FilterTableViewController: FilterItemDelegate {
    func valueChange(for itemIdentifier: String, to value: String) {
        if itemIdentifier == "releaseDate" {
            self.filters.setReleased(in: value)
        } else {
            self.filters.setGenre(named: value, using: self.genres)
        }
    }
}
