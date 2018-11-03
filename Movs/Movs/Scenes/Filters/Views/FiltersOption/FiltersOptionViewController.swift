//
//  FiltersOptionViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FiltersOptionViewController: UIViewController, FiltersOptionDisplayLogic {
    
    /// Type of the filters to display.
    var filterType: Filters.FiltersType?
    /// Filters to be displayed.
    var filters: [String] = []
    
    var dateFilter: Filters.Option.Selected?
    var genreFilter: Filters.Option.Selected?
    
    /// Index of the selected filter.
    var selectIndex: Int?
    /// Send selected filter.
    var filterSelected: ((Filters.Option.Selected) -> ())?
    
    var interactor: FiltersOptionBussinessLogic!
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.dataSource = self
        view.delegate = self
        view.register(UITableViewCell.self,
                      forCellReuseIdentifier: "Cell")
        return view
    }()
    
    // MARK: - Init
    
    init(filter: Filters.FiltersType) {
        filterType = filter
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Setup Methods
    
    /**
     Setup the entire scene.
     */
    private func setup() {
        let viewController = self
        let interactor = FiltersOptionInteractor()
        let presenter = FiltersOptionPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        setupViewController()
    }
    
    /**
     Setup view controller data.
     */
    private func setupViewController() {
        title = filterType!.description
        setupView()
    }
    
    // MARK: - ViewController Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let filter = filterType {
            let request = Filters.Option.Request(type: filter)
            interactor.filtersTo(request: request)
        }
    }
    
    // MARK: - Filters Methods
    
    func displayFilters(viewModel: Filters.Option.ViewModel) {
        filters = viewModel.filters
        tableView.reloadData()
    }
    
    /**
     When select a filter in a cell.
     
     - parameters:
         - index: Index of the cell selected.
     */
    func didSelectCell(at index: Int) {
        if let selectIndex = selectIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: selectIndex, section: 0))
            cell?.accessoryType = .none
            self.selectIndex = selectIndex == index ? nil : index
        } else {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .checkmark
            selectIndex = index
        }
        
        let (filterPredicate, filterName) = interactor.selectFilter(at: index)
        let filter = Filters.Option.Selected(type: filterType!,
                                             filterPredicate: filterPredicate,
                                             filterName: filterName)
        filterSelected?(filter)
    }
    
}

extension FiltersOptionViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        view.backgroundColor = .white
        tableView.backgroundColor = .clear
    }
}
