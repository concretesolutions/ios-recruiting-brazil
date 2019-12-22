//
//  MovieCellView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
final class MovieCollectionCellView: UICollectionViewCell {
    var movie:Movie?{
        didSet{
            if let movie = self.movie{
                setupUIData(movie: movie)
            }
        }
    }
    lazy var imageBackground:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        return view
    }()
    lazy var nameMovie:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = nil
        view.textColor = #colorLiteral(red: 0.8823153377, green: 0.7413565516, blue: 0.3461299241, alpha: 1)
        view.textAlignment = .left
        view.numberOfLines = 2
        return view
    }()
    lazy var favoriteButton:UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action:#selector(favoriteMovie), for: .touchDown)
        view.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        return view
    }()
    @objc func favoriteMovie(){
        if let movie = self.movie {
            save(movie: movie)
            favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        }
    }
    let container:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8.0
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    func setupUIData(movie: Movie){
        DispatchQueue.main.async {
            self.imageBackground.loadImageMovie(movie.backdropPath, width: 500)
            self.nameMovie.text = movie.title
            movieIsfavorite(by:movie.id) ? self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal) : self.favoriteButton.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame:.zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        self.movie  = nil
    }
}
extension MovieCollectionCellView: CodeView {
    func buildViewHierarchy() {
        self.contentView.addSubview(imageBackground)
        container.addArrangedSubview(nameMovie)
        container.addArrangedSubview(favoriteButton)
        self.addSubview(container)
    }
    
    func setupConstraints() {
        imageBackground.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nameMovie.snp.top)
        }
        container.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        nameMovie.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(8)
        }
        favoriteButton.imageView?.snp.makeConstraints({ (make) in
            make.height.equalTo(22)
            make.width.equalTo(20)
            make.right.equalToSuperview().inset(8)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
    }
    
    
}

