//
//  LikeButton.swift
//  Movs
//
//  Created by Lucca Ferreira on 11/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class LikeButton: UIButton {

    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                self.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }

    required init() {
        super.init(frame: .zero)
        self.tintColor = .systemOrange
        self.setupView()
        self.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LikeButton: ViewCode {

    func buildViewHierarchy() {}

    func setupContraints() {
        self.snp.makeConstraints { (make) in
            make.width.equalTo(40.0)
            make.height.equalTo(self.snp.width).multipliedBy(0.9)
        }
        self.imageView?.snp.makeConstraints({ (make) in
            make.edges.equalToSuperview()
        })
    }

    func setupAdditionalConfiguration() {}

}
