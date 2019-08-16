//
//  FilterOptionsViewController.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import Reusable
import SnapKit
import UIKit

public enum FilterOptions: String, CaseIterable {
    case date = "Date"
    case genre = "Genres"

    func localized() -> String {
        switch self {
        case .date:
            return "common.date".localized
        case .genre:
            return "common.genres".localized
        }
    }
}

class FilterOptionsViewController: UIViewController {

    var tableView = UITableView(frame: .zero, style: .grouped)
    let filterOptions = FilterOptions.allCases
    var parameters = ["1", "2", "3", "4", "5", "6"]
    var genresParameters: [String] = []
    var releasedYearsParameters: [String] = []
    var filter = Filter()
    var movies: [Movie] = []
    //swiftlint:disable weak_delegate
    var delegate: FilterDelegate?

    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupTableView()
    }

    init(movies: [Movie], delegate: FilterDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.getParameters(for: movies)
        self.movies = movies
    }

    func setupTableView() {
        self.title = "common.filter".localized
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.view.backgroundColor = self.tableView.backgroundColor
        self.tableView.register(cellType: FilterTableViewCell.self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getParameters(for movies: [Movie]) {
        self.genresParameters = []
        self.releasedYearsParameters = []

        movies.forEach { movie in
            movie.genres.forEach({
                if !self.genresParameters.contains($0.name ?? "") {
                    self.genresParameters.append($0.name ?? "")
                }
            })
            if !self.releasedYearsParameters.contains(movie.releaseYear) {
                self.releasedYearsParameters.append(movie.releaseYear)
            }
        }
    }

    @objc
    func applyFilter() {

        let filteredMovies = self.movies.filter({ movie -> Bool in
            var matchedYear = false
            var matchedGenre = false

            if let releasedYearFilter = self.filter.releaseYear {
                matchedYear = movie.releaseYear == releasedYearFilter
            } else {
                matchedYear = true
            }

            if let genreFilter = self.filter.genre {
                matchedGenre = movie.genres.contains(where: { $0.name?.lowercased() == genreFilter.lowercased() })
            } else {
                matchedGenre = true
            }

            return matchedYear && matchedGenre
        })

        self.delegate?.updateMovies(with: filteredMovies)
        self.navigationController?.popViewController(animated: true)
    }

}

extension FilterOptionsViewController: CodeView {

    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(button)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.top)
        }

        button.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
    }

    func setupAdditionalConfiguration() {
        button.setTitle("common.apply".localized, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Design.Colors.clearYellow
        button.layer.cornerRadius = 10.0
        button.addTarget(self, action: #selector(applyFilter), for: .touchUpInside)
    }

}

extension FilterOptionsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.05
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch indexPath.row {
        case 0:
            let filterParameters = FilterParametersTableViewController(parameters: self.releasedYearsParameters, option: filterOptions[indexPath.row], style: .grouped, delegate: self, selectedParameter: filter.releaseYear ?? "")
            self.navigationController?.pushViewController(filterParameters, animated: true)
        case 1:
            let filterParameters = FilterParametersTableViewController(parameters: self.genresParameters, option: filterOptions[indexPath.row], style: .grouped, delegate: self, selectedParameter: filter.genre ?? "")
            self.navigationController?.pushViewController(filterParameters, animated: true)
        default:
            break
        }

    }

}

extension FilterOptionsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterOptions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var parameter = ""
        switch indexPath.row {
        case 0:
            parameter = filter.releaseYear ?? ""
        case 1:
            parameter = filter.genre ?? ""
        default:
            parameter = ""
        }

        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterTableViewCell.self)
        cell.setupOption(with: filterOptions[indexPath.row].localized(), parameter: parameter)

        return cell
    }

}

extension FilterOptionsViewController: FilterDelegate {

    func updateParameter(for option: FilterOptions, with value: String) {
        self.filter.updateParameter(of: option, with: value)
        self.tableView.reloadData()
    }
}
