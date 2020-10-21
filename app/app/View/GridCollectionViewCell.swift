//
//  GridCollectionViewCell.swift
//  app
//
//  Created by rfl3 on 20/10/20.
//  Copyright © 2020 renacio. All rights reserved.
//

import AlamofireImage
import UIKit

class GridCollectionViewCell: UICollectionViewCell {

    // Variables
    var isFav: Bool = false {
        didSet {
            let image: UIImage?
            if self.isFav {
                image = UIImage(systemName: "heart.fill")
                self.favButton.tintColor = #colorLiteral(red: 0.8470588235, green: 0.3921568627, blue: 0.1607843137, alpha: 1)
            } else {
                image = UIImage(systemName: "heart")
                self.favButton.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
            }
            self.favButton.setImage(image, for: .normal)
        }
    }

    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }

            self.isFav = CoreDataService.shared.isFavorite(movie)
//            self.poster.af.setImage(withURL: withURL: , placeholderImage: )
            if let urlExtension = movie.posterPath,
                let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlExtension)")  {
                self.poster.af.setImage(withURL: url)
            }

        }
    }

    // Components
    let favButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setTitle(nil, for: .normal)
        view.setImage(UIImage(systemName: "heart"), for: .normal)
        view.tintColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)
        view.contentMode = .scaleAspectFit
        return view
    }()

    let poster: UIImageView = {
        let view = UIImageView(frame: .zero)
//        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.image = UIImage(named: "posterPlaceholder")
        return view
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func pressed(_ sender: UIButton) {
        guard let movie = self.movie else { return }
        self.isFav = !self.isFav

        if self.isFav {
            CoreDataService.shared.favoriteMovie(movie)
        } else {
            CoreDataService.shared.unfavoriteMovie(movie)
        }
    }

}

extension GridCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.poster)
        self.addSubview(self.favButton)
    }

    func setupConstraints() {
        self.favButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.left.top.equalTo(10)
        }

        self.poster.snp.makeConstraints { make in
            make.left.bottom.right.top.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.favButton.addTarget(self, action: #selector(self.pressed(_:)), for: .touchUpInside)

        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 10
        self.layer.shouldRasterize = true
    }


}
