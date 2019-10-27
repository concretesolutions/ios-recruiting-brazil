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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.posterView.contentMode = .scaleAspectFill
        self.posterView.clipsToBounds = true
        self.titleLbl.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        self.titleLbl.numberOfLines = 2
        self.yearLbl.font = UIFont.preferredFont(forTextStyle: .headline)
        self.descriptionView.isEditable = false
        self.descriptionView.font = UIFont.preferredFont(forTextStyle: .body)
        
        // testing block:
        self.posterView.image = UIImage(named: "stevenPoster")
        self.titleLbl.text = "Steven Universe: The Movie"
        self.yearLbl.text = "2019"
        self.genresLbl.text = "Animation, Drama"
        self.descriptionView.text = "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours."

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
