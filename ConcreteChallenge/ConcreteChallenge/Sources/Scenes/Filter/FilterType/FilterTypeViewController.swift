//
//  FilterTypeViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class FilterTypeViewController: UIViewController {
    private lazy var typeListCheckTableView: ListCheckTableView = {
        let tableView = ListCheckTableViewFactory.makeTableView()

        return tableView
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton()

        button.setTitle(Strings.apply.localizable, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.backgroundColor = .appYellowLight

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [typeListCheckTableView, applyButton])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        return stackView
    }()

    // MARK: - Private constants

    private let filterType = [Strings.date.localizable, Strings.genres.localizable]

    private let date: [String] = []

    private let genres: [String] = []

    // MARK: - Initializers

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func setupNavigation() {
        super.setupNavigation()
        title = Strings.filter.localizable
    }

    // MARK: - Private functions

    private func setup() {
        setupNavigation()
        setupLayout()
        setupActions()
        setupFilterType()
    }

    private func setupLayout() {
        applyButton.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView, constraints: [
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            applyButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        view.backgroundColor = .white
    }

    private func setupActions() {
        typeListCheckTableView.bind { [weak self] index in
            self?.listCheckItemTapped(index)
        }
    }

    private func listCheckItemTapped(_ index: Int) {
        switch index {
        case 0:
            print("load date data")
        default:
            print("load genres data")
        }
    }

    private func setupFilterType() {
        let listCheckItemsViewModel = filterType.map { filterType -> ListCheckItemViewModel in
            ListCheckItemViewModel(title: filterType, icon: .arrowForward)
        }
        typeListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }
}
