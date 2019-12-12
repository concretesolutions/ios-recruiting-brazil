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
        view.backgroundColor = .red
        view.contentMode = .scaleToFill
        view.image = #imageLiteral(resourceName: "favorite_gray_icon")
        return view
    }()
    let movieName:UILabel = {
        let view = UILabel(frame: .zero)
        //view.backgroundColor = .black
        view.text = "thor"
        view.font = UIFont(name: "Times New Roman", size: 30.0)
        return view
    }()
    let movieYear:UILabel = {
        let view = UILabel(frame: .zero)
        //view.backgroundColor = .black
        view.text = "2008"
        view.font = UIFont(name: "Times New Roman", size: 22.0)
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
            movieImage.loadImageMovie(movie.backdropPath, width: 500)
            movieName.text = movie.title
            movieYear.text = movie.releaseDate
            movieDescription.text = movie.overview
        }
    }
}
extension FavoriteMovieCellView:CodeView {
    func buildViewHierarchy() {
        self.addSubview(movieImage)
        self.addSubview(movieName)
        self.addSubview(movieYear)
        self.addSubview(movieDescription)
    }
    
    func setupConstraints() {
        movieImage.snp.makeConstraints { (make) in
            make.left.bottom.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        movieName.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(10)
        }
        movieYear.snp.makeConstraints { (make) in
            make.right.top.equalToSuperview().inset(10)
        }
        movieDescription.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(10)
            make.top.equalTo(movieName.snp.bottom).offset(10)
            make.right.equalTo(movieYear.snp.right)
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
    }
    
    
}
