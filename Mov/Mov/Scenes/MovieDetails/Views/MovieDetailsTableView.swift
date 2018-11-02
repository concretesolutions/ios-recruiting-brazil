//
//  MovieDetailsTableView.swift
//  Mov
//
//  Created by Miguel Nery on 01/11/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit


class MovieDetailsTableView: UITableView {
    
    static let titleCellReuseIdentifier = "detailsTitleCell"
    static let defaultLabelCellReuseIdentifier = "detailsDefaultLabelCell"
    static let overviewCellReuseIdentifier = "detailsOverviewCell"
    
    static let cellHeight = CGFloat(45).proportionalToHeight
    static let overviewCellHeight = CGFloat(255).proportionalToHeight
    
    
    init() {
        super.init(frame: .zero, style: .grouped)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailsTableView: ViewCode {
    func addView() {
        self.register(DetailsTitleTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableView.titleCellReuseIdentifier)
        self.register(DetailsDefaultLabelTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableView.defaultLabelCellReuseIdentifier)
        self.register(DetailsOverviewTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableView.overviewCellReuseIdentifier)
    }
    
    func addConstraints() {
        //
    }
    
    func additionalSetup() {
        self.bounces = false
        self.allowsSelection = false
        self.contentInset = .zero
        self.backgroundColor = .clear
    }
    
    
}
