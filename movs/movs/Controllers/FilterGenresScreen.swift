//
//  FilterGenresScreen.swift
//  movs
//
//  Created by Bruno Muniz Azevedo Filho on 28/12/18.
//  Copyright © 2018 bmaf. All rights reserved.
//

import UIKit

protocol FilterGenresScreenDelegate: class {
    func didSelectGenre(_ genre: Genre)
}

final class FilterGenresScreen: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var genresTableView: UITableView!

    // MARK: - Properties
    private let moviesDataPresenter = MoviesDataPresenter()
    private var genres = [Genre]() {
        didSet {
            genresTableView.reloadData()
        }
    }

    // MARK: - Delegate
    weak var delegate: FilterGenresScreenDelegate?
}

// MARK: - Lifecycle
extension FilterGenresScreen {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
}

// MARK: - Private
extension FilterGenresScreen {
    private func fetchData() {
        moviesDataPresenter.getGenres(completion: { genres in
            self.genres = genres
        }) {
            // TO DO
        }
    }
}

// MARK: - UITableViewDelegate
extension FilterGenresScreen: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectGenre(genres[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension FilterGenresScreen: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel!.text = genres[indexPath.row].name
        return cell!
    }
}
