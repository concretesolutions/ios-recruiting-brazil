//
//  DetailStackView.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class DetailStackView: UIStackView {

    // Variables
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }

            if let urlExtension = movie.backdropPath,
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlExtension)")  {
                self.poster.af.setImage(withURL: url)
            }

            self.title.text = movie.title
//            self.genres =
            self.overview.text = movie.overview
        }

    }

    // Components
    var poster: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
//        view.image = UIImage(named: "posterPlaceholder")
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
        self.addArrangedSubview(self.poster)
        self.addArrangedSubview(self.title)
        self.addArrangedSubview(self.genres)
        self.addArrangedSubview(self.overview)
    }

    func setupConstraints() {
        self.poster.snp.makeConstraints { make in
            make.top.left.right.equalTo(0)
            make.height.equalTo(self.poster.snp.height).multipliedBy(281/500)
        }

        self.title.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(0)
        }

        self.genres.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(0)
        }

        self.overview.snp.makeConstraints { make in
            make.top.right.left.equalTo(0)
            make.height.equalTo(100)
        }
    }

    func setupAdditionalConfiguration() {
        self.axis = .vertical
        self.alignment = .leading
        self.distribution = .equalCentering
    }


}
