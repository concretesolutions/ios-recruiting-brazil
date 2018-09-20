//
//  FavoriteCell.swift
//  Movies
//
//  Created by Jonathan Martins on 19/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
    // The cell's wrapper
    private let wrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 3
        view.addDropShadow()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // The cell's icon
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // The movie's name
    private let movieName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // The movie's release date
    private let movieDate: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .darkGray
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Adds the constraints to the views in this cell
    private func setupConstraints(){
        
        self.wrapper.addSubview(poster)
        self.wrapper.addSubview(movieName)
        self.wrapper.addSubview(movieDate)
        self.contentView.addSubview(wrapper)
        NSLayoutConstraint.activate([
            
            wrapper.heightAnchor .constraint(equalToConstant: 100),
            wrapper.topAnchor    .constraint(equalTo: self.contentView.topAnchor, constant: 5),
            wrapper.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            wrapper.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -10),
            wrapper.bottomAnchor .constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            
            poster.heightAnchor .constraint(equalToConstant: 90),
            poster.widthAnchor  .constraint(equalToConstant: 70),
            poster.topAnchor    .constraint(equalTo: wrapper.topAnchor, constant: 5),
            poster.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 5),
            poster.bottomAnchor .constraint(equalTo: wrapper.bottomAnchor, constant: -5),

            movieName.topAnchor     .constraint(equalTo: poster.topAnchor, constant: 5),
            movieName.leadingAnchor .constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -5),
            
            movieDate.topAnchor     .constraint(equalTo: movieName.bottomAnchor),
            movieDate.leadingAnchor .constraint(equalTo: movieName.leadingAnchor),
            movieDate.trailingAnchor.constraint(equalTo: movieName.trailingAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        contentView.backgroundColor = .appSecondColor
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Configures the Cell
    func setupCell(movie:Movie){

        /// Sets the name of the cell
        movieName.text = movie.title
        
        /// Sets the release date of the cell
        movieDate.text = movie.releaseDate.formatDate(fromPattern: "yyyy-mm-dd", toPattern: "d MMMM yyyy")
        
        /// Sets the icon of the cell
        if let url = movie.poster{
            poster.load(url)
        }
    }
}
