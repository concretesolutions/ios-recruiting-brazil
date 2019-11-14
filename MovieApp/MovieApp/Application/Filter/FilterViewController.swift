//
//  FilterViewController.swift
//  MovieApp
//
//  Created by Giuliano Accorsi on 13/11/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

enum DidSelectType: Int {
    case genre = 0
    case year = 1
}

class FilterViewController: UIViewController {
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var dataSource = FilterTableViewDataSource(tableView: self.tableView, delegate: self)
    
    override func loadView() {
        super.loadView()
        setupView()
        setupLayout()
        dataSource.test()
    }
        
    private func setupView() {
        self.navigationController?.view.tintColor = .orange
        title = "Filter"
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

extension FilterViewController: FilterDataSourceDelegate {
    func didSelected(index: Int) {
        switch index {
        case DidSelectType.genre.rawValue:
            let viewController = FilterDetailViewController(type: .genre)
            navigationController?.pushViewController(viewController, animated: true)
        case DidSelectType.year.rawValue:
            let viewController = FilterDetailViewController(type: .year)
            navigationController?.pushViewController(viewController, animated: true)
        default:
            return
        }
    }
}


    
