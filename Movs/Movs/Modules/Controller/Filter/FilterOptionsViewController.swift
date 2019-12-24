//
//  FilterOptionsViewController.swift
//  Movs
//
//  Created by Carolina Cruz Agra Lopes on 21/12/19.
//  Copyright © 2019 Carolina Lopes. All rights reserved.
//

import UIKit

class FilterOptionsViewController: UIViewController, DatesFilterDelegate, GenresFilterDelegate {

    // MARK: - Delegate

    weak var delegate: FilterApplyer?

    // MARK: - Screen

    private lazy var screen = FilterOptionsScreen()

    // MARK: - Specific filter view controllers

    private let datesVC = DatesFilterViewController()
    private let genresVC = GenresFilterViewController()

    // MARK: - DatesFilterDelegate

    var dates: [String] = []
    var tempSelectedDates: Set<String> = []

    // MARK: - GenresFilterDelegate

    var genres: [Genre] = []
    var tempSelectedGenres: Set<Genre> = []

    // MARK: - Cancel values

    private var selectedDates: Set<String> = []
    private var selectedGenres: Set<Genre> = []

    // MARK: - Life cycle

    override func loadView() {
        self.view = self.screen
        self.screen.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Filter"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Apply", style: .done, target: self, action: #selector(self.apply))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancel))

        self.datesVC.delegate = self
        self.genresVC.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.dates = Set(DataProvider.shared.favoriteMovies.map { $0.releaseYear }).sorted { $0 < $1 }
        self.genres = Set(DataProvider.shared.favoriteMovies.reduce([], { $0 + $1.genres })).sorted { $0.name < $1.name }

        self.selectedDates = self.selectedDates.filter { self.dates.contains($0) }
        self.selectedGenres = self.selectedGenres.filter { self.genres.contains($0)}

        self.screen.tableView.reloadData()
    }

    // MARK: - Navigation Bar actions

    @objc private func apply() {
        self.selectedDates = self.tempSelectedDates
        self.selectedGenres = self.tempSelectedGenres
        self.delegate?.updateData()
        self.dismiss(animated: true)
    }

    @objc private func cancel() {
        self.tempSelectedDates = self.selectedDates
        self.tempSelectedGenres = self.selectedGenres
        self.dismiss(animated: true)
    }

    // MARK: - Helpers

    func applyFilter() {
        if self.selectedDates.isEmpty && self.selectedGenres.isEmpty {
            self.delegate?.isFiltering = false
        } else {
            self.delegate?.isFiltering = true
            self.delegate?.filteredMovies = DataProvider.shared.favoriteMovies.filter { movie in
                self.selectedDates.contains(where: { $0 == movie.releaseYear }) && self.selectedGenres.contains(where: { movie.genres.contains($0) })
            }
        }
    }
}

extension FilterOptionsViewController: TableViewScreenDelegate {

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterOptionsCell.reuseIdentifier, for: indexPath) as? FilterOptionsCell else {
            fatalError("Wrong table view cell type")
        }

        switch indexPath.row {
        case 0:
            if self.tempSelectedDates.isEmpty {
                cell.configure(title: "Dates", detail: "")
            } else if self.tempSelectedDates.count == 1 {
                cell.configure(title: "Dates", detail: self.tempSelectedDates.first!)
            } else {
                cell.configure(title: "Dates", detail: "multiple")
            }
        case 1:
            if self.tempSelectedGenres.isEmpty {
                cell.configure(title: "Genres", detail: "")
            } else if self.tempSelectedGenres.count == 1 {
                cell.configure(title: "Genres", detail: self.tempSelectedGenres.first!.name)
            } else {
                cell.configure(title: "Genres", detail: "multiple")
            }
        default:
            fatalError("Invalid indexPath row")
        }

        return cell
    }

    // MARK: - UITabelViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(self.datesVC, animated: true)
        case 1:
            self.navigationController?.pushViewController(self.genresVC, animated: true)
        default:
            fatalError("Invalid indexPath row")
        }
    }
}

extension FilterOptionsViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.tempSelectedDates = self.selectedDates
        self.tempSelectedGenres = self.selectedGenres
    }
}
