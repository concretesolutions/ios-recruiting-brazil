//
//  MovieDetailViewControllerView.swift
//  app
//
//  Created by rfl3 on 21/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import UIKit

class MovieDetailViewControllerView: UIView {

    // Variables
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }

            if let urlExtension = movie.backdropPath,
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlExtension)")  {
                self.stackView.poster.af.setImage(withURL: url)
            }

            self.stackView.title.text = movie.title
            //            self.genres =
            self.stackView.overview.text = movie.overview
        }

    }

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
            make.height.equalToSuperview().multipliedBy(0.7)
            make.center.equalTo(self.snp.center)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .white
    }


}
