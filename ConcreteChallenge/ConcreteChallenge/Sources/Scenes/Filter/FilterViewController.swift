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

protocol FilterDisplayLogic: AnyObject {
    func onFetchedDates(viewModel: Filter.FetchDates.ViewModel)
    func onFetchedGenres(viewModel: Filter.FetchGenres.ViewModel)
    func displayGenericError()
}

final class FilterViewController: UIViewController, FilterDisplayLogic {
    private lazy var typeListCheckTableView: ListCheckTableView = ListCheckTableViewFactory.make()

    private lazy var dataPickerListCheckTableView: ListCheckTableView = ListCheckTableViewFactory.make()

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

    // MARK: - Variables

    weak var delegate: FilterViewControllerDelegate?

    // MARK: - Private variables

    private var filterIndexType = FilterIndexType.date

    private var allDates: [String] = []

    private var allGenres: [String] = []

    private var date: [String] = []

    private var genres: [String] = []

    // MARK: - Private constants

    private let interactor: FilterBusinessLogic

    private let filterType = [Strings.date.localizable, Strings.genres.localizable]

    // MARK: - Initializers

    init(interactor: FilterBusinessLogic) {
        self.interactor = interactor

        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    // MARK: - Override functions

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchDatas()
        setup()
    }

    override func setupNavigation() {
        super.setupNavigation()

        let backButtonImage = UIImage(assets: .arrowBack)?.resize(size: CGSize(width: 20, height: 20))
        let barButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: .didBackButtonTapped)
        navigationItem.leftBarButtonItem = barButtonItem
    }

    // MARK: - FilterDisplayLogic

    func onFetchedDates(viewModel: Filter.FetchDates.ViewModel) {
        allDates = viewModel.dates
    }

    func onFetchedGenres(viewModel: Filter.FetchGenres.ViewModel) {
        allGenres = viewModel.genres
    }

    func displayGenericError() {
        // Show some error messasge
    }

    // MARK: - Private functions

    private func fetchDatas() {
        interactor.fetchGenres(request: Filter.FetchGenres.Request(language: Constants.MovieDefaultParameters.language))
        interactor.fetchDates()
    }

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

        applyButton.addTarget(self, action: .didApplyButtonTapped, for: .touchUpInside)
    }

    private func listCheckItemTapped(_ index: Int) {
        switch index {
        case FilterIndexType.date.rawValue:
            filterIndexType = FilterIndexType.date
        default:
            filterIndexType = FilterIndexType.genres
        }

        setupList()
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

        setupFilterType()
        setupList()
    }

    private func setupFilterType() {
        title = Strings.filter.localizable

        showTypeListCheckTableView()

        let listCheckItemsViewModel = filterType.map { filterType -> ListCheckItemViewModel in
            let value = filterType == Strings.date.localizable ? date.joined(separator: Constants.Utils.genresSeparator) : genres.joined(separator: Constants.Utils.genresSeparator)
            return ListCheckItemViewModel(title: filterType, value: value, icon: .arrowForward)
        }
        typeListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }

    private func setupList() {
        var listCheckItemsViewModel: [ListCheckItemViewModel] = []
        showDataPickerListCheckTableView()

        switch filterIndexType {
        case FilterIndexType.date:
            title = Strings.date.localizable

            listCheckItemsViewModel = allDates.map { allDatesItem -> ListCheckItemViewModel in
                let dateStored = date.first { $0 == allDatesItem }
                return ListCheckItemViewModel(title: allDatesItem, icon: dateStored != nil ? .checkIcon : nil)
            }
        default:
            title = Strings.genres.localizable

            listCheckItemsViewModel = allGenres.map { allGenresItem -> ListCheckItemViewModel in
                let genreStored = genres.first { $0 == allGenresItem }
                return ListCheckItemViewModel(title: allGenresItem, icon: genreStored != nil ? .checkIcon : nil)
            }
        }

        dataPickerListCheckTableView.setupDataSource(items: listCheckItemsViewModel)
    }

    private func showTypeListCheckTableView() {
        dataPickerListCheckTableView.isHidden = true
        typeListCheckTableView.isHidden = false
        applyButton.isHidden = !(date.count > 0 || genres.count > 0)
    }

    private func showDataPickerListCheckTableView() {
        dataPickerListCheckTableView.isHidden = false
        typeListCheckTableView.isHidden = true
        applyButton.isHidden = true
    }

    // MARK: - Fileprivate functions

    @objc fileprivate func didBackButtonTapped() {
        if !dataPickerListCheckTableView.isHidden {
            showTypeListCheckTableView()
        } else {
            navigationController?.popViewController(animated: true)
        }
    }

    @objc fileprivate func didApplyButtonTapped() {
        let filter = FilterSearch(date: date, genres: genres)
        delegate?.filterApplyButtonTapped(filter: filter, self)
    }
}

private extension Selector {
    static let didBackButtonTapped = #selector(FilterViewController.didBackButtonTapped)
    static let didApplyButtonTapped = #selector(FilterViewController.didApplyButtonTapped)
}
