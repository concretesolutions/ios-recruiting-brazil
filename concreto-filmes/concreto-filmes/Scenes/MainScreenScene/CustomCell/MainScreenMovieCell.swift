//
//  MainScreenMovieCell.swift
//  concreto-filmes
//
//  Created by Leonel Menezes on 23/10/18.
//  Copyright © 2018 Leonel Menezes. All rights reserved.
//

import UIKit
import SDWebImage
import SnapKit

class MainScreenMovieCell: UICollectionViewCell {

    private var coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.clipsToBounds = true
        label.numberOfLines = 2
        return label
    }()

    private var favoriteImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private var bottomView: UIView = {
        let view = UIView()
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(data: MainScreen.ViewModel.MovieViewModel) {
        self.coverImage.sd_setImage(with: URL(string: data.posterUrl)) { (image, _, _, _) in
            if image == nil {
                DispatchQueue.main.async {
                    self.coverImage.image = #imageLiteral(resourceName: "placeholder")
                }
            }
        }
        self.titleLabel.text = data.title
        
        self.favoriteImage.image = data.isFavorite ? #imageLiteral(resourceName: "favorite_full_icon") : #imageLiteral(resourceName: "favorite_gray_icon")
    }
}

extension MainScreenMovieCell: CodeView {
    func buildViewHierarchy() {
        addSubview(self.coverImage)
        addSubview(self.titleLabel)
        addSubview(self.favoriteImage)
    }

    func setupConstraints() {
        self.coverImage.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        self.favoriteImage.snp.makeConstraints { (maker) in
            maker.height.equalTo(20)
            maker.width.equalTo(20)
            maker.centerY.equalTo(titleLabel)
            maker.right.equalTo(self).inset(5)
        }
        
        self.titleLabel.snp.makeConstraints { (maker) in
            maker.height.equalTo(50)
            maker.left.equalTo(self).offset(5)
            maker.right.equalTo(self.favoriteImage).inset(25)
            maker.bottom.equalTo(self)
        }
    }

    func setupAdditionalConfiguration() {
        self.backgroundColor = .black
        
        self.applyGradient(colours: [.clear, .black], locations: [0.5, 1.0])
        self.titleLabel.layer.zPosition = 5
        self.favoriteImage.layer.zPosition = 5
    }

}
