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
    private var viewModel: DetailsViewModel!
    
    private let realm = try! Realm()
    private var itemsFavorites = [FavoriteEntity]()
    
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
        setupVerifyFavorites()
        setupValuesMovie()
        setupViewModel()
        setupStates()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movs details"
    }
    
    private func setupVerifyFavorites() {
        itemsFavorites = realm.objects(FavoriteEntity.self).map({ $0 })
                
        if itemsFavorites.contains(where: {$0.id == movies.id}) {
            detailsView.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        } else {
            detailsView.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
    }
    
    private func setupValuesMovie() {
        detailsView.photo.downloadImage(from: (Constants.pathPhoto + movies.poster_path))
        detailsView.title.text = movies.title
        detailsView.year.text = Constants.getYear(movies: movies)
        detailsView.genre.text = Constants.getGenresString(movies: movies)
        detailsView.overview.text = movies.overview
    }
    
    private func setupViewModel() {
        viewModel = DetailsViewModelFactory().create()
    }
}

extension DetailsViewController: DetailsDelegate {
    func btnFavorite() {
        if detailsView.favorite.currentImage == UIImage(named: "favorite_gray_icon") {
            detailsView.favorite.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
            addToFavorite(movie: movies)
        } else {
            detailsView.favorite.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
            removeFavorite(movie: movies)
        }
    }
    
    private func addToFavorite(movie: ResultMoviesDTO) {
        viewModel.loadAddToFavorite(realm: realm, movie: movie)
    }
    
    private func removeFavorite(movie: ResultMoviesDTO) {
        viewModel.loadRemoveFavorite(realm: realm, movie: movie)
    }
    
    private func setupStates() {
        viewModel.successAdding.observer(viewModel) { message in
            print(message)
        }
        
        viewModel.successRemoving.observer(viewModel) { message in
            print(message)
        }
    }
}
