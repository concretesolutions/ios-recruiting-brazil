//
//  FilterDetailViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 13/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class FilterDetailViewController: UIViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsMultipleSelection = false
        tableView.allowsMultipleSelectionDuringEditing = false
        return tableView
    }()
    
    private lazy var dataSource = FilterDetailDataSource(tableView: self.tableView, delegate: self)
    private let controller = FilterDetailController()
    private var genrOrYear: DidSelectType
    
    init(type: DidSelectType) {
        self.genrOrYear = type
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupView()
        setupLayout()
        controller.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if genrOrYear == .genre {
            title = Strings.labelGenreFilter
            controller.getGenres()
        } else {
            title = Strings.labelYearFilter
            controller.getYears()
        }
    }
    
    private func setupView() {
        self.navigationController?.view.tintColor = .orange
        self.navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.font: UIFont(name: Strings.fontProject, size: 30)!,
             NSAttributedString.Key.foregroundColor: UIColor.orange]
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension FilterDetailViewController: FilterDetailControllerDelegate {
    func updateMovies(genreDate: [String]) {
        dataSource.updateGenresDate(genreDate: genreDate)
    }
}

extension FilterDetailViewController: FilterDetailDataSourceDelegate {
    func didSelect(text: String) {
        if genrOrYear == .genre {
            UserDefaults.standard.set(text, forKey: Strings.userDefaultsFilterDetailGenreKey)
        } else {
            UserDefaults.standard.set(text, forKey: Strings.userDefaultsFilterDetailYearKey)
        }
    }
}

