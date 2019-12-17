//
//  MovieDetailsView.swift
//  Movs
//
//  Created by Lucca Ferreira on 04/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {

    @Published private var posterImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 16.0
        imageView.image = UIImage()  //Problem related
        return imageView
    }()

    private let movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        return label
    }()

    private let movieReleaseYear: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        return label
    }()

    private let movieOverview: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textAlignment = .natural
        return label
    }()

    required init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieDetailsView: ViewCode {

    func buildViewHierarchy() {

    }

    func setupContraints() {

    }

    func setupAdditionalConfiguration() {}
    
}
