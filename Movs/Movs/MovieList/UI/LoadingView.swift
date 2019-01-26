//
//  LoadingView.swift
//  Movs
//
//  Created by Filipe Jordão on 25/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {
    let activityIndicator = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LoadingView: ViewConfiguration {
    func setupViews() {
        activityIndicator.color = .movsBlue
        activityIndicator.startAnimating()
    }

    func setupHierarchy() {
        addSubview(activityIndicator)
    }

    func setupConstraints() {
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.height.equalTo(activityIndicator.snp.width)
            make.width.equalTo(self).dividedBy(5)
        }
    }
}
