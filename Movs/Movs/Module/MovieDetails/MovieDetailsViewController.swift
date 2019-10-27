//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    private let posterView = UIImageView()
    private let titleLbl = UILabel()
    private let yearLbl = UILabel()
    private let genresLbl = UILabel()
    private let descriptionView = UITextView()
    
    var viewModel: MovieDetailsViewModel! {
        didSet {
            self.posterView.image = self.viewModel.posterImg
            self.titleLbl.text = self.viewModel.titleText
            self.yearLbl.text = self.viewModel.yearText
            self.genresLbl.text = self.viewModel.genresText
            self.descriptionView.text = self.viewModel.descriptionText
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.title = "Movie"
        
        self.posterView.contentMode = .scaleAspectFill
        self.posterView.clipsToBounds = true
        self.titleLbl.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.titleLbl.numberOfLines = 2
        self.yearLbl.font = UIFont.preferredFont(forTextStyle: .headline)
        self.descriptionView.isEditable = false
        self.descriptionView.font = UIFont.preferredFont(forTextStyle: .body)

        self.view.addSubviews([self.posterView, self.titleLbl, self.yearLbl, self.genresLbl, self.descriptionView])
        UIView.translatesAutoresizingMaskIntoConstraints(to: [self.posterView, self.titleLbl, self.yearLbl, self.genresLbl, self.descriptionView])
        // TODO: maybe set the poster's height relative to the superview's height?
        NSLayoutConstraint.activate([
            self.posterView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.posterView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.posterView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.posterView.heightAnchor.constraint(equalToConstant: 300),
            
            self.titleLbl.topAnchor.constraint(equalTo: self.posterView.bottomAnchor, constant: 10),
            self.titleLbl.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.titleLbl.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            
            self.yearLbl.topAnchor.constraint(equalTo: self.titleLbl.bottomAnchor),
            self.yearLbl.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor),
            
            self.genresLbl.bottomAnchor.constraint(equalTo: self.yearLbl.bottomAnchor),
            self.genresLbl.leadingAnchor.constraint(equalTo: self.yearLbl.trailingAnchor, constant: 10),
            self.genresLbl.trailingAnchor.constraint(lessThanOrEqualTo: self.view.layoutMarginsGuide.trailingAnchor),
            
            self.descriptionView.topAnchor.constraint(equalTo: self.yearLbl.bottomAnchor, constant: 10),
            self.descriptionView.leadingAnchor.constraint(greaterThanOrEqualTo: self.view.layoutMarginsGuide.leadingAnchor),
            self.descriptionView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            self.descriptionView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
