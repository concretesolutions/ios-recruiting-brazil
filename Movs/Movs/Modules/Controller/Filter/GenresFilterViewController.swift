//
//  GenresFilterViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 22/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class GenresFilterViewController: UIViewController {

    // MARK: - Delegate

    weak var delegate: GenresFilterDelegate?

    // MARK: - Screen

    private let screen = FilterScreen()

    // MARK: - Model

    private var genres: [(Int, String)] = []

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Genres"
        self.navigationItem.largeTitleDisplayMode = .never
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(self.clear))
    }

    override func viewWillAppear(_ animated: Bool) {
        self.genres = self.delegate?.genres.sorted(by: { $0.value < $1.value }) ?? []
        self.screen.tableView.reloadData()
    }

    // MARK: - Clear

    @objc private func clear() {
        self.delegate?.tempSelectedGenreIds = []
        self.screen.tableView.reloadData()
    }
}

extension GenresFilterViewController: TableViewScreenDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.genres.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterCell.reuseIdentifier, for: indexPath) as? FilterCell else {
            fatalError("Wrong table view cell type")
        }

        guard let delegate = self.delegate else {
            fatalError("No delegate")
        }

        let (id, genre) = self.genres[indexPath.row]

        cell.configure(title: genre)
        cell.accessoryView = delegate.tempSelectedGenreIds.contains(id) ? UIImageView(image: UIImage(systemName: "checkmark")) : nil

        return cell
    }

    // MARK: - UITabelViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            fatalError("No delegate")
        }

        let (id, _) = self.genres[indexPath.row]

        if delegate.tempSelectedGenreIds.contains(id) {
            delegate.tempSelectedGenreIds.remove(id)
        } else {
            delegate.tempSelectedGenreIds.insert(id)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
