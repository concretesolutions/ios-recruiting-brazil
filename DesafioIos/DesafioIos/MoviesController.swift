//
//  MoviesController.swift
//  DesafioConcrete
//
//  Created by Kacio Henrique Couto Batista on 05/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import UIKit
import SnapKit
class MoviesController: UIViewController , SendDataApi {
    var moviesData:[Movie] = [] {
        didSet{
            DispatchQueue.main.async {
                self.filterMovies = self.moviesData
                self.collectionView.reloadData()
            }
        }
    }
    var filterMovies:[Movie] = []
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .lightGray
        return cv
    }()
    lazy var searchBar: UISearchBar = {
        let view = UISearchBar(frame: .zero)
        view.backgroundColor = .black
        return view
    }()
    override func loadView() {
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = .red
        self.view = view
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDataMovie()
    }
    func setupDataMovie(){
        let maneger = ManegerApiRequest()
        maneger.delegate = self
        maneger.sendMovies()
    }
    func sendMovie(movies: [Movie]) {
        moviesData.append(contentsOf: movies)
    }

}
// MARK: - Protocols of CollectionView

extension MoviesController:UICollectionViewDataSource, UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filterMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCellView 
        cell.movie = self.filterMovies[indexPath.row]
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
//MARK: - Protocols Search Bar
extension MoviesController:UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchBar.text == "" {
            self.filterMovies = self.moviesData
        } else {
            filterMovies = self.moviesData.filter({ (movie) -> Bool in
                return movie.title.lowercased().contains(searchBar.text!.lowercased())
            })
        }
        self.collectionView.reloadData()
    }
}
// MARK: - Protocols CodeView
extension MoviesController:CodeView{
    func buildViewHierarchy() {
        view.addSubview(collectionView)
        view.addSubview(searchBar)
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.top.equalTo(searchBar.snp.bottom)
        }
        searchBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(80)
        }
    }
    
    func setupAdditionalConfiguration() {
        collectionView.register(MovieCellView.self,forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
    }
    
    
}

