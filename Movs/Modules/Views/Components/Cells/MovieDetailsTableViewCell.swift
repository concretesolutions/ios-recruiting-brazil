//
//  MovieDetailsTableViewCell.swift
//  Movs
//
//  Created by Gabriel D'Luca on 16/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit
import Combine

class MovieDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Interface Elements
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0, weight: .bold)
        label.textColor = UIColor(named: "detailsLabel")
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17.0, weight: .medium)
        label.textColor = UIColor(named: "detailsSecondaryLabel")
        return label
    }()
    
    // MARK: - Initializers and Deinitializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.setupView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieDetailsTableViewCell: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(self.headingLabel)
        self.contentView.addSubview(self.contentLabel)
    }
    
    func setupConstraints() {
        self.headingLabel.snp.makeConstraints({ make in
            make.top.leading.equalTo(self.contentView).offset(24.0)
        })
        
        self.contentLabel.snp.makeConstraints({ make in
            make.top.equalTo(self.headingLabel.snp.bottom).offset(8.0)
            make.leading.equalTo(self.headingLabel)
            make.trailing.equalTo(self.contentView).inset(24.0)
            make.bottom.equalTo(self.contentView)
        })
    }
}
