//
//  FilterOptionsViewControllerScreen.swift
//  movies
//
//  Created by Jacqueline Alves on 18/12/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

final class FilterOptionsViewControllerScreen: UIView {
    
    lazy var tableView: UITableView = {
        let view: UITableView = UITableView(frame: .zero)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "FilterOptionCell")
        view.backgroundColor = .systemBackground
        view.separatorStyle = .singleLine
        view.tableFooterView = UIView()
        
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterOptionsViewControllerScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().inset(10)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .systemBackground
    }
}
