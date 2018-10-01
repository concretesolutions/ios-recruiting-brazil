//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        lbDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
            + " ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut"
            + " aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum"
            + " dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"
            + " deserunt mollit anim id est laborum."
            + "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
            + " ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut"
            + " aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum"
            + " dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"
            + " deserunt mollit anim id est laborum."
        lbDescription.sizeToFit()
    }

    private func setupViews() {
        imageHeight.constant = UIScreen.main.bounds.width - 16
        let favoriteImage = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
}
