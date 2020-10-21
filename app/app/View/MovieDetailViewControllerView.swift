//
//  MovieDetailViewControllerView.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class MovieDetailViewControllerView: UIView {

    // Components
    var stackView = DetailStackView()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MovieDetailViewControllerView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.stackView)
    }

    func setupConstraints() {
        self.stackView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.6)
            make.center.equalTo(self.snp.center)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }


}
