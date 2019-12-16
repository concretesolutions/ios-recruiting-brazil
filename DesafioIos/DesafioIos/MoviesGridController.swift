//
//  MoviesController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
class MoviesGridController: UIViewController , SendDataApi {
    var moviesData:[Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.filterMovies = self.moviesData
                self.collectionView.reloadData()
            }
        }
    }
    var filterMovies:[Movie] = [] {
        didSet{
            if !self.filterMovies.isEmpty{
                DispatchQueue.main.async {
                    self.collectionView.isHidden = false
                }
            }
        }
    }
    let maneger = ManegerApiRequest()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    let stateView = MoviesGridStatusView(state: .sending)
    override func loadView() {
        self.view = MoviesGridStatusView(image: #imageLiteral(resourceName: "search_icon"), descriptionScreen: "not found movie X")
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
        self.title = "Movies"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataMovie()
        makeSearchController()
    }
    
    func makeSearchController(){
        let searchController = UISearchController(nibName: nil, bundle: nil)
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        searchController.searchResultsUpdater = self
    }
    func setupDataMovie(){
       
        maneger.delegate = self
        maneger.sendMovies(page: 6)
    }
// MARK: - Func to Get Movies From api
    func sendMovie(movies: [Movie]) {
        moviesData.append(contentsOf: movies)
    }
// MARK: - Func to Get Status From api
    func sendStatus(status: StatusConnection) {
        if status == .sending {
            DispatchQueue.main.async {
                self.collectionView.isHidden = true
                self.stateView.isHidden = false
                self.stateView.state = status
            }
        
        }
        if status == .finish{
            DispatchQueue.main.async {
                self.collectionView.isHidden = false
                self.stateView.isHidden = true
            }
        }
        if status == .dontConnection{
           DispatchQueue.main.async {
              self.collectionView.isHidden = true
              self.stateView.isHidden = false
              self.stateView.state = .dontConnection
           }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

}
// MARK: - Protocols of CollectionView

extension MoviesGridController:UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCellView
        cell.setupUIData(movie: filterMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width
        return CGSize(width: (width)/2.5, height: (width)/2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailMovieController()
        vc.movie = self.filterMovies[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
//MARK: - Protocols SearchBarController Updating
extension MoviesGridController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text == "" {
            self.filterMovies = self.moviesData
        } else {
            filterMovies = self.moviesData.filter({ (movie) -> Bool in
                return movie.title.lowercased().contains(searchController.searchBar.text!.lowercased())
            })
            if self.filterMovies.isEmpty {
                DispatchQueue.main.async {
                    self.collectionView.isHidden = true
                }
            }
        }
        self.collectionView.reloadData()
    }
}
// MARK: - Protocols CodeView
extension MoviesGridController:CodeView{

    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(stateView)
    }

    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.bottom.left.right.top.equalToSuperview()
        }

    }
    func setupAdditionalConfiguration() {
        collectionView.register(MovieCellView.self,forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }


}

