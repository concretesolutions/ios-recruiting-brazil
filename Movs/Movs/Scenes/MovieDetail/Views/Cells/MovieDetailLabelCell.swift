//
//  MovieDetailLabelCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailLabelCell: UITableViewCell {
    
    lazy var label: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension MovieDetailLabelCell: CodeView {
    func buildViewHierarchy() {
        addSubview(label)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalToSuperview()
            make.height.equalTo(45)
        }
    }
    
    func setupAdditionalConfiguration() {}
}
