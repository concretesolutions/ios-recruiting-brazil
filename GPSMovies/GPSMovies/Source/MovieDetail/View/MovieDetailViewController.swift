//
//  MovieDetailViewController.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright (c) 2019 Gilson Santos. All rights reserved.
//

import UIKit
import Cosmos

class MovieDetailViewController: UIViewController {
    
    // MARK: OUTLETS
    @IBOutlet weak var imagePoster: UIImageView!
    
    @IBOutlet weak var imageSmall: UIImageView!
    @IBOutlet weak var labelRating: UILabel!
    @IBOutlet weak var labelNameMovie: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var textFieldDescription: UITextView!

    // MARK: CONSTANTS
    
    // MARK: VARIABLES
    private var presenter: MovieDetailPresenter!
    private lazy var viewData:MovieDetailViewData = MovieDetailViewData()
    
    // MARK: IBACTIONS
}

//MARK: - LIFE CYCLE -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MovieDetailPresenter(viewDelegate: self)
    }
}

//MARK: - DELEGATE PRESENTER -
extension MovieDetailViewController: MovieDetailViewDelegate {

}

//MARK: - AUX METHODS -
extension MovieDetailViewController {

}
