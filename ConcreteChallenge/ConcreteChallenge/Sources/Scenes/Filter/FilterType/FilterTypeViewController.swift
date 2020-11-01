//
//  FilterTypeViewController.swift
//  ConcreteChallenge
//
//  Created by Adrian Almeida on 01/11/20.
//  Copyright © 2020 Adrian Almeida. All rights reserved.
//

import UIKit

enum FilterIndexType: Int {
    case date = 0
    case genres = 1
}

final class FilterTypeViewController: UIViewController {
    private lazy var typeListCheckTableView: ListCheckTableView = ListCheckTableViewFactory.makeTableView()

    private lazy var dataPickerListCheckTableView: ListCheckTableView = ListCheckTableViewFactory.makeTableView()

    private lazy var listStackView = UIStackView(arrangedSubviews: [typeListCheckTableView, dataPickerListCheckTableView])

    private lazy var applyButton: UIButton = {
        let button = UIButton()

        button.setTitle(Strings.apply.localizable, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)

        button.backgroundColor = .appYellowLight

        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [listStackView, applyButton])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)

        return stackView
    }()

    // MARK: - Private variables

    private var filterIndexType = FilterIndexType.genres

    private var date: [String] = []

    private var genres: [String] = []

    // MARK: - Private constants

    private let filterType = [Strings.date.localizable, Strings.genres.localizable]

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

        let backImage = UIImage(assets: .arrowBack)?.resize(size: CGSize(width: 20, height: 20))
        let barButtonItem = UIBarButtonItem(image: backImage, style: .plain, target: self, action: .didBackButtonTapped)
        navigationItem.leftBarButtonItem = barButtonItem
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

        dataPickerListCheckTableView.bind { [weak self] index in
            self?.pickDataItemTapped(index)
        }
    }

    private func listCheckItemTapped(_ index: Int) {
        switch index {
        case FilterIndexType.date.rawValue:
            filterIndexType = FilterIndexType.date
            setupDateList()
        default:
            filterIndexType = FilterIndexType.genres
            setupGenresList()
        }
    }

    private func pickDataItemTapped(_ index: Int) {
        switch filterIndexType {
        case FilterIndexType.date:
            if let removeIndex = date.firstIndex(of: allDates[index]) {
                date.remove(at: removeIndex)
            } else {
                date.append(allDates[index])
            }
        default:
            if let removeIndex = genres.firstIndex(of: allGenres[index]) {
                genres.remove(at: removeIndex)
            } else {
                genres.append(allGenres[index])
            }
        }

        print(date)
        print(genres)
    }

    private func setupFilterType() {
        title = Strings.filter.localizable

        dataPickerListCheckTableView.isHidden = true
        typeListCheckTableView.isHidden = false
        applyButton.isHidden = false

        let listCheckItemsViewModel = filterType.map { filterType -> ListCheckItemViewModel in
            ListCheckItemViewModel(title: filterType, icon: .arrowForward)
        }
        typeListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }

    private func showTypeListCheckTableView() {
        dataPickerListCheckTableView.isHidden = true
        typeListCheckTableView.isHidden = false

        applyButton.isHidden = !(date.count > 0 || genres.count > 0)
    }

    // MARK: - Fileprivate functions

    @objc fileprivate func didBackButtonTapped() {
        if !dataPickerListCheckTableView.isHidden {
            showTypeListCheckTableView()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    // MARK: - Move to interactor

    private func setupDateList() {
        title = Strings.date.localizable

        dataPickerListCheckTableView.isHidden = false
        typeListCheckTableView.isHidden = true
        applyButton.isHidden = true

        let listCheckItemsViewModel = allDates.map { date -> ListCheckItemViewModel in
            ListCheckItemViewModel(title: date)
        }
        dataPickerListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }

    private func setupGenresList() {
        title = Strings.genres.localizable

        dataPickerListCheckTableView.isHidden = false
        typeListCheckTableView.isHidden = true
        applyButton.isHidden = true

        let listCheckItemsViewModel = allGenres.map { date -> ListCheckItemViewModel in
            ListCheckItemViewModel(title: date)
        }
        dataPickerListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }

    private let allDates = ["2020", "2019", "2018", "2017", "2016", "2015", "2020", "2019", "2018", "2017", "2016", "2015", "2020", "2019", "2018", "2017", "2016", "2015"]

    private let allGenres = ["Action", "Ação", "Comédia", "Velozes", "Romantico", "Terror", "Aventura", "Kids", "Adulto", "Sexy hot"]
}

private extension Selector {
    static let didBackButtonTapped = #selector(FilterTypeViewController.didBackButtonTapped)
}
