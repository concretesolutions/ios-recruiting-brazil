//
//  DetailMovieView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 11/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class DetailMovieView: UIView {
    let movieImage:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.image = #imageLiteral(resourceName: "list_icon")
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
        stack.distribution = .equalSpacing
        stack.backgroundColor = .red
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8.0
        return stack
    }()
    lazy var favoriteButton:UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        return view
    }()
    lazy var movieName:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "nome do filme"
        view.font = UIFont(name: "Times New Roman", size: 30.0)
        return view
    }()
    lazy var movieYear:UILabel = {
           let view = UILabel(frame: .zero)
           view.text = "2008"
           view.font = UIFont(name: "Times New Roman", size: 30.0)
           return view
    }()
    lazy var movieGenre:UILabel = {
           let view = UILabel(frame: .zero)
           view.text = "Action,adventure"
           view.font = UIFont(name: "Times New Roman", size: 30.0)
           return view
    }()
    let movieDescription:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "foi o deus nórdico do trovão (por isto representava a força da natureza), talvez o mais popular deus da mitologia nórdica. Ele tinha um martelo chamado Mjolnir (o destruidor), feito por anões das cavernas subterrâneas, com o qual dominava o trovão."
        view.font = UIFont(name: "Times New Roman", size: 15.0)
        view.lineBreakMode = .byCharWrapping
        view.numberOfLines = 3
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension DetailMovieView:CodeView{
    func buildViewHierarchy() {
        self.addSubview(movieImage)
        containerNameMovieLikeButton.addArrangedSubview(movieName)
        containerNameMovieLikeButton.addArrangedSubview(favoriteButton)
        containerDescriptionMovie.addArrangedSubview(containerNameMovieLikeButton)
        containerDescriptionMovie.addArrangedSubview(movieYear)
        containerDescriptionMovie.addArrangedSubview(movieGenre)
        self.addSubview(containerDescriptionMovie)
        self.addSubview(movieDescription)
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().inset(80)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        containerNameMovieLikeButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        containerDescriptionMovie.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(movieImage.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        movieDescription.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(containerDescriptionMovie.snp.bottom)
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
}
