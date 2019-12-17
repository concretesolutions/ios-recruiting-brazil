//
//  MovieCellView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
final class MovieCellView: UICollectionViewCell {
    var movie:Movie? {
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
        view.textColor = .yellow
        view.textAlignment = .center
        return view
    }()
    lazy var favoriteButton:UIButton = {
        let view = UIButton(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action:#selector(favoriteMovie), for: .touchDown)
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
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    private func setupUIData(movie: Movie){
        imageBackground.loadImageMovie(movie.backdropPath, width: 500)
        nameMovie.text = movie.title
        movieIsfavorite(by:movie.id) ? favoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal) : favoriteButton.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
    }
    override init(frame: CGRect) {
        super.init(frame:.zero)
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension MovieCellView: CodeView {
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
        favoriteButton.imageView?.snp.makeConstraints({ (make) in
            make.width.height.equalTo(20)
        })
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
    }
    
    
}

