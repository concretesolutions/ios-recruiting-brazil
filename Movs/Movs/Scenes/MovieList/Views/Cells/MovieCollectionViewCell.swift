//
//  MovieCollectionViewCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 25/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Title"
        view.numberOfLines = 0
        view.font = UIFont.systemFont(ofSize: 20)
        view.textColor = UIColor.Movs.yellow
        view.textAlignment = .center
        return view
    }()
    
    lazy var favoriteButton: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: Constants.ImageName.favoriteGray), for: .normal)
        view.addTarget(self, action: #selector(MovieCollectionViewCell.pressedFavorite), for: .touchUpInside)
        return view
    }()
    
    var didPressButton: ((UIButton) -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    func set(movie: MovieList.ViewModel.Movie) {
        let posterUrl = URL(string: movie.posterURL)
        guard let url = posterUrl else { return }
        title.text = movie.title
        imageView.kf.setImage(with: url)
        favoriteButton.setImage(UIImage(named: movie.favoriteImageName), for: .normal)
    }
    
    @objc func pressedFavorite(sender: UIButton) {
        didPressButton?(favoriteButton)
    }
    
}

extension MovieCollectionViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(imageView)
        addSubview(title)
        addSubview(favoriteButton)
    }
    
    func setupConstraints() {
        imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.right.equalToSuperview().multipliedBy(0.75)
            make.top.equalTo(imageView.snp.bottom)
        }
        
        favoriteButton.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview()
            make.left.equalTo(title.snp.right)
            make.top.equalTo(imageView.snp.bottom)
        }
        
        favoriteButton.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(25)
        })
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.Movs.darkGray
    }
}
