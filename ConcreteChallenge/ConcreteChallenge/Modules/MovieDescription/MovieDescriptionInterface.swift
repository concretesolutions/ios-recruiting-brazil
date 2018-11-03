//
//  MovieDescriptionInterface.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 30/10/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

class MovieDescriptionInterface: UIViewController {
    lazy var manager = MovieDescriptionManager(self)
    
    @IBOutlet weak var cardContentView: CardContentView!
    @IBOutlet weak var topLabelDescription: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.manager.load()
        
        self.cardContentView.delegate = self
    }
    
    func set(movie: Movie) {
        self.manager.set(movie: movie)
    }
    
}

extension MovieDescriptionInterface: MovieDescriptionInterfaceProtocol {
    func set(imageURL: String, title: String, year: Int, genres: [Genre], isSaved: Bool) {
        self.cardContentView.imageView?.sd_setImage(with: URL(string: imageURL), completed: nil)
        
        self.cardContentView.movieTitle.text = title

        var topLabel = ""

        for genre in genres {
            topLabel.append(contentsOf: genre.name + (genre != genres.last ? ", " : ""))
        }

        self.topLabelDescription.text = String(year) + (topLabel.isEmpty ? "" : "- \(topLabel)")

        self.cardContentView.setSaveButton(isSaved: isSaved)
    }
    
    
}

extension MovieDescriptionInterface: CardContentViewDelegate {
    func saveTapped() {
        self.manager.save()
    }
}




