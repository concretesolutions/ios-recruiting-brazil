//
//  DetailsViewController.swift
//  Movs
//
//  Created by Joao Lucas on 10/10/20.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController {
    
    private let detailsView = DetailsView()
    
    var movies: ResultMoviesDTO!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = detailsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsView.delegate = self

        setupNavigationBar()
        setupValuesMovie()
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movs details"
    }
    
    private func setupValuesMovie() {
        detailsView.photo.downloadImage(from: (Constants.pathPhoto + movies.poster_path))
        detailsView.title.text = movies.title
        detailsView.year.text = Constants.getYear(movies: movies)
        detailsView.genre.text = Constants.getGenresString(movies: movies)
        detailsView.overview.text = movies.overview
    }
}

extension DetailsViewController: DetailsDelegate {
    func btnFavorite() {
        if detailsView.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
            detailsView.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            detailsView.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
}
