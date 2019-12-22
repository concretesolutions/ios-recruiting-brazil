//
//  FavoriteMovieCellView.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit

class FavoriteMovieCellView: UITableViewCell {
    var movie:Movie?{
        didSet{
            self.updateUI()
        }
    }
    let movieImage:UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleToFill
        //view.image = #imageLiteral(resourceName: "favorite_gray_icon")
        return view
    }()
    let movieName:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "thor"
        view.font = UIFont(name: "Helvetica-Bold", size: 25.0)
        //view.numberOfLines = 3
        return view
    }()
    let movieYear:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "2008"
        view.font = UIFont(name: "Helvetica", size: 20.0)
        return view
    }()
    lazy var containerMovieNameAndMovieYear:UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let movieDescription:UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "foi o deus nórdico do trovão (por isto representava a força da natureza), talvez o mais popular deus da mitologia nórdica. Ele tinha um martelo chamado Mjolnir (o destruidor), feito por anões das cavernas subterrâneas, com o qual dominava o trovão."
        view.font = UIFont(name: "Helvetica", size: 15.0)
        view.lineBreakMode = .byTruncatingMiddle
        view.numberOfLines = 3
        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func updateUI(){
        if let movie = self.movie{
            movieImage.loadImageMovie(movie.backdropPath, width: 200)
            movieName.text = movie.title
            movieYear.text = formateYear(date:movie.releaseDate)
            movieDescription.text = movie.overview
        }
    }
}
extension FavoriteMovieCellView:CodeView {
    func buildViewHierarchy() {
        self.containerMovieNameAndMovieYear.addArrangedSubview(movieName)
        self.containerMovieNameAndMovieYear.addArrangedSubview(movieYear)
        self.addSubview(containerMovieNameAndMovieYear)
        self.addSubview(movieImage)
        self.addSubview(movieDescription)
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        containerMovieNameAndMovieYear.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(8)
            make.top.right.equalToSuperview().inset(8)
        }
        movieDescription.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(8)
            make.right.equalToSuperview()
            make.top.equalTo(containerMovieNameAndMovieYear.snp.bottom).offset(8)
        }

    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    
}
