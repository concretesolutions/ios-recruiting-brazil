//
//  MovieDetailView.swift
//  ios-recruiting-brazil
//
//  Created by Adriel Freire on 14/12/19.
//  Copyright © 2019 Adriel Freire. All rights reserved.
//

import UIKit
class MovieDetailView: UIView, ConfigView {
    let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let detailsTable: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func createViewHierarchy() {
        self.addSubview(movieImage)
        self.addSubview(detailsTable)
    }
    func addConstraints() {
        //movieImage constraint
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            movieImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            movieImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4)
        ])
        //detailsTable constraints
        NSLayoutConstraint.activate([
            detailsTable.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            detailsTable.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            detailsTable.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            detailsTable.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setAdditionalConfiguration() {
        self.backgroundColor = .white
    }

}
