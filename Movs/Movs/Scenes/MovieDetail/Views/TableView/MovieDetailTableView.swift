//
//  MovieDetailTableView.swift
//  Movs
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailTableView: UITableView {
    
    lazy var titleCell: MovieDetailButtonCell = {
        let view = MovieDetailButtonCell(frame: .zero)
        return view
    }()
    
    lazy var yearCell: MovieDetailLabelCell = {
        let view = MovieDetailLabelCell(frame: .zero)
        return view
    }()
    
    lazy var genreCell: MovieDetailLabelCell = {
        let view = MovieDetailLabelCell(frame: .zero)
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

extension MovieDetailTableView: CodeView {
    func buildViewHierarchy() {
        addSubview(titleCell)
        addSubview(yearCell)
        addSubview(genreCell)
    }
    
    func setupConstraints() {}
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
        isScrollEnabled = false
        dataSource = self
        delegate = self
    }
}
