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
    static let defaultCellReuseIdentifier = "detailsDefaultCell"
    
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
    }
    
    func addConstraints() {
        //
    }
    
    func additionalSetup() {
        self.rowHeight = CGFloat(35).proportionalToHeight
    }
    
    
}
