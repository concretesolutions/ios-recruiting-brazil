//
//  MovieDetailsViewController.swift
//  Movs
//
//  Created by Dielson Sales on 30/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    enum Constants {
        static let nibName = "MovieDetailsViewController"
    }

    @IBOutlet weak var imageHeight: NSLayoutConstraint!

    @IBOutlet weak var lbYear: UILabel!
    @IBOutlet weak var lbCategory: UILabel!
    @IBOutlet weak var lbDescription: UILabel!

    init() {
        super.init(nibName: Constants.nibName, bundle: nil)
        self.title = "Violet Evergarden"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        let image = UIImage(named: "buttonFavorite")?.withRenderingMode(.alwaysTemplate)
        let rightButtonItem = UIBarButtonItem(
            image: image,
            style: .plain,
            target: self,
            action: #selector(onFavoriteButtonTapped)
        )
        navigationItem.rightBarButtonItem = rightButtonItem

        lbDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
        + " ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
        + " aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum"
        + " dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"
        + " deserunt mollit anim id est laborum."
        + "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt"
        + " ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi"
        + " aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum"
        + " dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia"
        + " deserunt mollit anim id est laborum."
    }

    @objc private func onFavoriteButtonTapped() {
        print("Favorited")
    }

    private func setupViews() {
        imageHeight.constant = UIScreen.main.bounds.width - 16
    }
}
