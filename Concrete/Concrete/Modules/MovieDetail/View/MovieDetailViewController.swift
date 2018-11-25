//
//  MovieDetailTableViewController.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 25/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var outletPoster: UIImageView!
    @IBOutlet weak var outletTitle: UILabel!
    @IBOutlet weak var outletAge: UILabel!
    @IBOutlet weak var outletGenre: UILabel!
    @IBOutlet weak var outletOverview: UITextView!
    @IBOutlet weak var outletFavoriteButton: UIButton!
    
    // MARK: - Properties
    // MARK: Private
    // MARK: Public
    var presenter:MovieDetailPresenter!
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter.viewDidLoad()
    }

    // MARK: - Functions
    // MARK: Private
    // MARK: Public
    func set(title:String) {
        self.outletTitle.text = title
    }
    
    func set(age:NSDate) {
        let date = age as Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        self.outletAge.text = dateFormatter.string(from: date)
    }
    
    func set(genreTitles:[String]) {
        let title = genreTitles.joined(separator: ", ")
        
        self.outletGenre.text = title
    }
    
    func set(overview:String) {
        self.outletOverview.text = overview
    }
    
    func set(poster:UIImage) {
        self.outletPoster.image = poster
    }
    
    func set(isFavorite:Bool) {
        switch isFavorite {
        case true:
            self.outletFavoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        case false:
            self.outletFavoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
        }
    }
    
}
