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

class MainScreenMovieCell : UICollectionViewCell {
    
    private lazy var coverImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        return btn
    }()
    
    private lazy var bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.75
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setData(data: MainScreen.FetchPopularMuvies.ViewModel.MovieViewModel){
        self.coverImage.sd_setImage(with: URL(string: "https://image.tmdb.org/t/p/w500" + data.posterUrl), completed: nil)
        self.titleLabel.text = data.title
    }
}

extension MainScreenMovieCell : CodeView {
    func buildViewHierarchy() {
        addSubview(self.coverImage)
        addSubview(self.bottomView)
        addSubview(self.titleLabel)
    }
    
    func setupConstraints() {
        self.coverImage.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        self.bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.bottom.equalTo(self)
            make.left.equalTo(self)
            make.right.equalTo(self)
        }
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.bottomView)
            make.left.equalTo(self.bottomView).offset(5)
            make.right.equalTo(self.bottomView).inset(5)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .red
    }
    
    
}
