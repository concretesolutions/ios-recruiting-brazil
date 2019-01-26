//
//  ErrorView.swift
//  Movs
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    let xLabel = UILabel()
    let errorLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ErrorView: ViewConfiguration {
    func setupViews() {
        xLabel.font = UIFont.systemFont(ofSize: 100)
        xLabel.textAlignment = .center
        xLabel.text = "X"
        xLabel.textColor = .red

        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.textColor = .movsBlue
        errorLabel.font = UIFont.systemFont(ofSize: 40)
        errorLabel.text = "Um erro ocorreu. Por favor, tente novamente."
    }

    func setupHierarchy() {
        [xLabel, errorLabel].forEach(addSubview)
    }

    func setupConstraints() {
        xLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.8)
            make.height.equalTo(xLabel.snp.width)
        }

        errorLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.top.equalTo(xLabel.snp.bottom).offset(30)
            make.width.equalTo(self).multipliedBy(0.8)
        }
    }
}
