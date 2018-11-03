//
//  FiltersOptionViewController.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FiltersOptionViewController: UIViewController, FiltersOptionDisplayLogic {
    
    var filterType: Filters.FiltersType?
    var filters: [String] = []
    
    var dateFilter: Filters.Option.Selected?
    var genreFilter: Filters.Option.Selected?
    
    var selectIndex: Int?
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
    
    init(filter: Filters.FiltersType) {
        filterType = filter
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setup() {
        let viewController = self
        let interactor = FiltersOptionInteractor()
        let presenter = FiltersOptionPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        setupViewController()
    }
    
    private func setupViewController() {
        title = filterType!.description
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let filter = filterType {
            let request = Filters.Option.Request(type: filter)
            interactor.filtersTo(request: request)
        }
    }
    
    func displayFilters(viewModel: Filters.Option.ViewModel) {
        filters = viewModel.filters
        tableView.reloadData()
    }
    
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
