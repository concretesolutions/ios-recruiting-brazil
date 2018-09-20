//
//  FilterView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FilterView: UIView {
    
    /// The filters options
    let tableView:UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.separatorStyle  = .singleLine
        tableView.backgroundColor = .white
        tableView.register(FilterCell.self, forCellReuseIdentifier: FilterCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // Adds the constraints to this view
    private func setupConstraints(){
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// The cell for the filter's items
class FilterCell:UITableViewCell {
    
    static let identifier = "FilterCell"
    
    // The filter's title
    let title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        self.contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant:5)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        accessoryType  = .disclosureIndicator
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// The footer for the apply button
class FilterFooterCell: UIView{
    
    // The "apply" button
    let buttonApply: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appColor
        button.cornerRadius = 23
        button.setTitle("Apply", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(buttonApply)
        NSLayoutConstraint.activate([
            buttonApply.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonApply.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonApply.widthAnchor  .constraint(equalToConstant: 213),
            buttonApply.heightAnchor .constraint(equalToConstant: 45),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
