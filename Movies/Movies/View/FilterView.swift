//
//  FilterView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

//import UIKit
//
//class FilterView: UIView {
//    
//    /// The filters options
//    let tableView:UITableView = {
//        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
//        tableView.separatorStyle  = .singleLine
//        tableView.backgroundColor = .white
//        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//    // Adds the constraints to this view
//    private func setupConstraints(){
//        self.addSubview(tableView)
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
//            tableView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
//        ])
//    }
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.backgroundColor = .appColor
//        setupConstraints()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
