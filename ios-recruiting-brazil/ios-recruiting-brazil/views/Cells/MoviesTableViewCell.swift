//
//  MoviesTableViewCell.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MoviesTableViewCell: UITableViewCell, ConfigView {

    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .darkGray
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let movieName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let date: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let movieDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createViewHierarchy() {
        self.addSubview(movieImage)
        self.addSubview(movieName)
        self.addSubview(date)
        self.addSubview(movieDescription)
    }

    func addConstraints() {
        //movieImage constraints
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: self.topAnchor),
            movieImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        //date constraints
        NSLayoutConstraint.activate([
            date.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            date.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            date.heightAnchor.constraint(equalToConstant: date.font.pointSize),
            date.widthAnchor.constraint(equalToConstant: 50)
        ])
        //movieName constraints
        NSLayoutConstraint.activate([
            movieName.topAnchor.constraint(equalTo: date.topAnchor),
            movieName.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 10),
            movieName.heightAnchor.constraint(equalToConstant: movieName.font.pointSize),
            movieName.trailingAnchor.constraint(equalTo: date.leadingAnchor, constant: -10)
        ])
        //movieDescription constraints
        NSLayoutConstraint.activate([
            movieDescription.leadingAnchor.constraint(equalTo: movieName.leadingAnchor),
            movieDescription.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 10),
            movieDescription.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            movieDescription.trailingAnchor.constraint(equalTo: date.trailingAnchor)
        ])
    }
    func setAdditionalConfiguration() {
        self.backgroundColor = .lightGray
        self.selectionStyle = .none
    }
}

extension  MoviesTableViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
}
