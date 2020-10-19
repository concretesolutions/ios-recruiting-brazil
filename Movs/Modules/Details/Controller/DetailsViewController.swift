//
//  DetailsViewController.swift
//  Movs
//
//  Created by Joao Lucas on 10/10/20.
//

import UIKit
import RealmSwift

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    private let detailsView = DetailsView()
    var movies: ResultMoviesDTO!
    private var viewModel: DetailsViewModel!
    
    private let realm = try! Realm()
    private var itemsFavorites = [FavoriteEntity]()
    
    private var castList = [ResultImageDTO]()
    
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

        setupCollectionView()
        setupViewModel()
        setupFetchCast()
        setupNavigationBar()
        setupVerifyFavorites()
        setupValuesMovie()
        setupStates()
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Movs details"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupVerifyFavorites()
    }
    
    private func setupCollectionView() {
        detailsView.collectionCast.delegate = self
        detailsView.collectionCast.dataSource = self
        
        detailsView.collectionCast.register(CastViewCell.self, forCellWithReuseIdentifier: "listCredits")
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

extension DetailsViewController {
    private func setupFetchCast() {
        viewModel.fetchCast(idMovie: movies.id)
            .successObserver(onSuccess)
            .loadingObserver(onLoading)
            .errorObserver(onError)
    }
    
    private func onSuccess(cast: ImagesDTO) {
        self.castList = cast.posters
        detailsView.collectionCast.reloadData()
    }
    
    private func onLoading() {
        print("Carregando")
    }
    
    private func onError(message: HTTPError) {
        let errorView = ErrorView()
        self.view = errorView
        print(message.localizedDescription)
    }
}

extension DetailsViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return castList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCredits", for: indexPath) as! CastViewCell
        
        let cast = castList[indexPath.row]
        cell.photo.downloadImage(from: (Constants.pathPhoto + cast.file_path))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
