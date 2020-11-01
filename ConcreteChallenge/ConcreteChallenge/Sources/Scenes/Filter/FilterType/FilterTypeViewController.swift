//
//  FilterTypeViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

final class FilterTypeViewController: UIViewController {
    private lazy var item: ListCheckItemView = {
        let item = ListCheckTableViewFactory.makeTableView()

        return item
    }()

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

    func setup() {
        setupNavigation()
        setupLayout()
    }

    func setupLayout() {
        view.addSubview(item, constraints: [
            item.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            item.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            item.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            item.heightAnchor.constraint(equalToConstant: 24)
        ])

        view.backgroundColor = .white
    }
}
