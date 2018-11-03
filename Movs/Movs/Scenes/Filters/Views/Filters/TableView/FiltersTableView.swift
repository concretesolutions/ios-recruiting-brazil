//
//  FiltersTableView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FiltersTableView: UITableView {
    
    lazy var date: FiltersTableViewCell = {
        let view = FiltersTableViewCell(frame: .zero)
        view.accessoryType = .disclosureIndicator
        view.detailTextLabel?.text = ""
        view.detailTextLabel?.textColor = UIColor.Movs.lightYellow
        view.textLabel?.text = "Date"
        return view
    }()
    
    lazy var genre: FiltersTableViewCell = {
        let view = FiltersTableViewCell(frame: .zero)
        view.accessoryType = .disclosureIndicator
        view.detailTextLabel?.text = ""
        view.detailTextLabel?.textColor = UIColor.Movs.lightYellow
        view.textLabel?.text = "Genres"
        return view
    }()
    
    override init(frame: CGRect = .zero, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension FiltersTableView: CodeView {
    func buildViewHierarchy() {
        addSubview(date)
        addSubview(genre)
    }
    
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        isScrollEnabled = false
    }
}
