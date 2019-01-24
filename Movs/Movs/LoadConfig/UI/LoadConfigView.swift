//
//  LoadConfigView.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class LoadConfigView: UIView {
    let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadConfigView: ViewConfiguration {
    func setupViews() {
        backgroundColor = .movsYellow

        titleLabel.text = "Movs"
        titleLabel.textColor = .movsBlue
        titleLabel.font = UIFont.systemFont(ofSize: 45)
    }

    func setupHierarchy() {
        addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
    }
}
