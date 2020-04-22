//
//  MovieDetailViewController.swift
//  Movies-Browser
//
//  Created by Gustavo Severo on 18/04/20.
//  Copyright © 2020 Severo. All rights reserved.
//

import UIKit
import SDWebImage

class MovieDetailViewController: UIViewController {
    // MARK: - Variables
    weak var coordinator: MovieDetailCoordinator?
    weak var viewModel: MovieDetailViewModel?
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - IBActions
    @IBAction func favoriteAction(_ sender: Any) {
        viewModel?.favoriteButtonWasTapped()
    }
}

// MARK: - ViewModel -
extension MovieDetailViewController {
    func setupViewModelListener(){
        viewModel?.callback = { [weak self] state in
            self?.posterImageURLDidChange(state.posterImageURL)
            self?.titleTextDidChange(state.titleText)
            self?.releaseDateTextDidChange(state.releaseDateText)
            self?.genresListTextDidChange(state.genreListText)
            self?.descriptionTextDidChange(state.descriptionText)
            self?.isFavoriteDidChange(state.isFavorite)
        }
    }
}

// MARK: - Events -
extension MovieDetailViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewModelListener()
    }
}

// MARK: - State UI Updates -
extension MovieDetailViewController {
    func posterImageURLDidChange(_ url: String){
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
    }
    
    func isFavoriteDidChange(_ state: Bool){
        if state {
            favoriteButton.setTitle("Remove from the favorite list", for: .normal)
            favoriteButton.setImage(UIImage(named: "star-filled")?.withRenderingMode(.alwaysTemplate), for: .normal)
            
        } else {
            favoriteButton.setTitle("Add to the favorite list", for: .normal)
            favoriteButton.setImage(UIImage(named: "star")?.withRenderingMode(.alwaysTemplate), for: .normal)
        }
    }
    
    func titleTextDidChange(_ text: String){
        self.titleLabel.text = text
    }
    
    func releaseDateTextDidChange(_ text: String){
        self.releaseDateLabel.text = text
    }
    
    func genresListTextDidChange(_ text: String){
        self.genresLabel.text = text
    }
    
    func descriptionTextDidChange(_ text: String){
        self.descriptionLabel.text = text
    }
}
