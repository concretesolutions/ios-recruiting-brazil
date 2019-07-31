//
//  MovieDetailsView.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

final class MovieDetailsView: UIView {
    //MARK:- Views -
    
    private(set) var image: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    private(set) var title: UILabel = {
        let view = UILabel()
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 30)!
        return view
    }()
    
    private(set) var favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "favorite_empty_icon"), for: .normal)
        button.setImage(UIImage(named: "favorite_full_icon"), for: .selected)
        
        return button
    }()
    
    private(set) var year: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private(set) var genre: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private(set) var overview: UITextView = {
        let view = UITextView()
        view.isEditable = false
        view.textAlignment = NSTextAlignment.justified
        return view
    }()
    
    //MARK:- Constructors -
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    
    fileprivate func buildDivider() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    fileprivate func setupUIElements() {
        // arrange subviews
        backgroundColor = .white
        
        self.addSubview(image)
        self.addSubview(title)
        self.addSubview(favoriteButton)
        self.addSubview(year)
        self.addSubview(genre)
        self.addSubview(overview)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        image.snp.makeConstraints {
            (ConstraintMaker) in
            ConstraintMaker.top.bottom.equalToSuperview()
            ConstraintMaker.right.left.equalTo(guide)
        }
        
        title.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(guide).multipliedBy(3)
            ConstraintMaker.right.left.equalTo(guide).inset(10)
            ConstraintMaker.width.equalTo(guide).multipliedBy(0.8)
        }
        
        favoriteButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.centerY.equalTo(title)
            ConstraintMaker.height.width.equalTo(guide.snp.width).multipliedBy(0.2).inset(15)
            ConstraintMaker.right.equalTo(guide.snp.right).inset(10)
        }
        
        favoriteButton.imageView?.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.height.width.equalTo(favoriteButton)
        }
        
        year.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(title.snp.bottom).offset(5)
            ConstraintMaker.right.left.equalTo(guide).inset(10)
            ConstraintMaker.height.equalTo(title)
        }
        
        genre.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(year.snp.bottom).offset(5)
            ConstraintMaker.right.left.equalTo(guide).inset(10)
            ConstraintMaker.height.equalTo(year).multipliedBy(1)
        }
        
        overview.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(genre.snp.bottom).offset(5)
            ConstraintMaker.bottom.equalTo(guide).inset(10)
            ConstraintMaker.right.left.equalTo(guide).inset(5)
        }
    }
    
    
    /// Cria um gradiente por cima da imageView
    ///
    /// - Parameters:
    ///   - colorTop: cor da parte de cima da view (Primeira cor do gradiente)
    ///   - colorBottom: cor da parte de baixo da view (Segunda cor do gradiente)
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.locations = [0, 0.6]
        gradientLayer.isOpaque = false
        gradientLayer.frame = UIScreen.main.bounds
        
        self.image.layer.addSublayer(gradientLayer)
    }
}
