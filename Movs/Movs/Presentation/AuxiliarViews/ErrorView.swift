//
//  ErrorView.swift
//  Movs
//
//  Created by Douglas Silveira Machado on 12/08/19.
//  Copyright © 2019 Douglas Silveira Machado. All rights reserved.
//

import SnapKit
import UIKit

class ErrorView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

}

extension ErrorView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(label)
        self.addSubview(imageView)
    }

    func setupConstraints() {

        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalTo(imageView.snp.centerX)
        }

        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.9)
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalTo(imageView.snp.width)
        }

    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white

        label.contentMode = .scaleAspectFit
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25.0)
        label.numberOfLines = 0
        label.textColor = .black
        label.text = "generic.error.message".localized

        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "errorIcon")
    }
}
