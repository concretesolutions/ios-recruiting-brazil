//
//  DetailMovieView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 11/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class DetailMovieView: UIView {
    let movie:Movie
    lazy var movieImage:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.loadImageMovie(self.movie.backdropPath, width: 500)
        view.contentMode = .scaleAspectFit
        return view
    }()
    lazy var containerNameMovieLikeButton:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    lazy var containerDescriptionMovie:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        return stack
    }()
    lazy var favoriteButton:UIButton = {
        let view = UIButton(frame: .zero)
        if(movieIsfavorite(by: self.movie.id)){
            view.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        }else{
            view.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        }
        view.addTarget(DetailMovieController(), action: #selector(DetailMovieController.favoriteMovie(sender:)), for: .touchDown)
        return view
    }()
  
    lazy var movieName:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = self.movie.title
        view.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.numberOfLines = 4
        return view
    }()
    lazy var movieYear:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = formateYear(date:self.movie.releaseDate)
        view.font = UIFont(name: "Helvetica", size: 20.0)
        view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return view
    }()
    lazy var movieGenre:UILabel = {
           let view = UILabel(frame: .zero)
           view.font = UIFont(name: "Helvetica", size: 20.0)
           view.text = formatGenres(list: self.movie.genreIDS)
           view.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           return view
    }()
    lazy var movieDescription:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = self.movie.overview
        view.font = UIFont(name: "Helvetica", size: 20.0)
        view.lineBreakMode = .byTruncatingMiddle
        view.numberOfLines = 5
        view.textColor = #colorLiteral(red: 0.5276738405, green: 0.5793740153, blue: 0.6459704638, alpha: 1)
        return view
    }()
    init(movie:Movie) {
        self.movie = movie
        super.init(frame: UIScreen.main.bounds)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DetailMovieView:CodeView{
    func buildViewHierarchy() {
        self.addSubview(movieImage)
        //containerDescriptionMovie.addArrangedSubview(movieImage)
        containerNameMovieLikeButton.addArrangedSubview(movieName)
        containerNameMovieLikeButton.addArrangedSubview(favoriteButton)
        containerDescriptionMovie.addArrangedSubview(containerNameMovieLikeButton)
        containerDescriptionMovie.addArrangedSubview(movieYear)
        containerDescriptionMovie.addArrangedSubview(movieGenre)
        containerDescriptionMovie.addArrangedSubview(movieDescription)
        self.addSubview(containerDescriptionMovie)
        //self.addSubview(movieDescription)
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        containerNameMovieLikeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        containerDescriptionMovie.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.top.equalTo(movieImage.snp.bottom).inset(35)
        }
        favoriteButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(25)
        }
    }
        
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1757613122, green: 0.1862640679, blue: 0.2774662971, alpha: 1)
    }
}
