//
//  FilterOptionsViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class FilterOptionsViewController: UIViewController {
    
    var tableView = UITableView(frame: .zero, style: .grouped)
    let filterOptions = ["Date", "Genres"]
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        self.title = "Filter"
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .white
        self.view.backgroundColor = self.tableView.backgroundColor
        self.tableView.register(cellType: FilterOptionsTableViewCell.self)
    }
    
}

extension FilterOptionsViewController: CodeView {
    
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(button.snp.top)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalTo(tableView.snp.bottom)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(30)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
    }
    
    func setupAdditionalConfiguration() {
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = Design.Colors.clearYellow
        button.layer.cornerRadius = 10.0
    }
    
}


extension FilterOptionsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.05
    }
    
}

extension FilterOptionsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filterOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: FilterOptionsTableViewCell.self)
        cell.setup(with: filterOptions[indexPath.row])
        return cell
    }
    
}

