//
//  DetailStackView.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class DetailStackView: UIView {

    // Components
    var poster: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "backdropPlaceholder")
        return view
    }()

    var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = view.font.withSize(17)
        return view
    }()

    var genres: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = view.font.withSize(15)
        return view
    }()

    var overview: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = view.font.withSize(13)
        view.numberOfLines = 0
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailStackView: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.poster)
        self.addSubview(self.title)
        self.addSubview(self.genres)
        self.addSubview(self.overview)
    }

    func setupConstraints() {
        self.poster.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(200)
        }

        self.title.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.poster.snp.bottom).offset(20)
            make.top.bottom.right.left.equalTo(0)
        }

        self.genres.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.title.snp.bottom).offset(20)
            make.top.bottom.right.left.equalTo(0)
        }

        self.overview.snp.makeConstraints { make in
            make.right.left.equalToSuperview()
            make.top.equalTo(self.genres.snp.bottom).offset(20)
            make.height.equalTo(100)
        }
    }

    func setupAdditionalConfiguration() {
    }

}
