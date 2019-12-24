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

    private var genres: [Genre] = []

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
        self.genres = self.delegate?.genres ?? []
        self.screen.tableView.reloadData()
    }

    // MARK: - Clear

    @objc private func clear() {
        self.delegate?.tempSelectedGenres = []
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

        let genre = self.genres[indexPath.row]

        cell.configure(title: genre.name)
        cell.accessoryView = delegate.tempSelectedGenres.contains(genre) ? UIImageView(image: UIImage(systemName: "checkmark")) : nil

        return cell
    }

    // MARK: - UITabelViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            fatalError("No delegate")
        }

        let genre = self.genres[indexPath.row]

        if delegate.tempSelectedGenres.contains(genre) {
            delegate.tempSelectedGenres.remove(genre)
        } else {
            delegate.tempSelectedGenres.insert(genre)
        }

        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
