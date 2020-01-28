//
//  MoviesViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class ListViewController: UIViewController{
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    var isSearching:Bool = false
    
    lazy var collectionView:UICollectionView = {
        
        //gridView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = CGFloat(0)
        flowLayout.minimumInteritemSpacing = CGFloat(0)
        flowLayout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        //delegates
        collectionView.dataSource = self
        collectionView.delegate = self
        //cell setup
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "MovieCell")
        return collectionView
        
    }()
    
    lazy var searchBar:UISearchBar = {
        let searchBar = UISearchBar()
        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.barTintColor = .clear
        searchBar.barStyle = .default
        searchBar.isTranslucent = true
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.placeholder = "Search for movies"
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
    //MARK: -Init methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(hex: dao.concreteDarkGray)
        safeArea = view.layoutMarginsGuide
        setContraints()
        getMovie(page:1)
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            for cell in self.collectionView.visibleCells{
                let movieCell = cell as! MovieCollectionViewCell
                movieCell.refreshFavorite()
            }
        }
    }
    
    //MARK: - Complimentary Methods
    private func getMovie(page:Int){
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=0c909c364c0bc846b72d0fe49ab71b83&language=en-US&page=\(page)" 
        let anonymousFunc = {(fetchedData:MovieSearch) in
            DispatchQueue.main.async {
                for movie in fetchedData.results{
                    movie.isFavorite = false
                    dao.searchResults.append(movie)
                }
                self.collectionView.reloadData()
            }
        }
        api.movieSearch(urlStr: url, view: self, onCompletion: anonymousFunc)
    }
    
    //MARK:- Constraints
    private func setContraints(){
        
        searchBar.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        searchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        searchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: view.frame.height/8).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:safeArea.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

//MARK:- Extensions and Delegates
extension ListViewController:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !isSearching{ return dao.searchResults.count} else {return dao.filteredMovies.count}
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MovieCollectionViewCell
        
        if !isSearching{
            let movie = dao.searchResults[indexPath.row]
            movie.isFavorite = false
            cell.setUp(movie:movie)
            cell.refreshFavorite()
        }else{
            let movie = dao.filteredMovies[indexPath.row]
             movie.isFavorite = false
            cell.setUp(movie:movie)
            cell.refreshFavorite()
        }

    
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == dao.searchResults.count - 1 {
            let page = dao.page + 1
            getMovie(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width/2
        let height = self.view.frame.height/2
        let size:CGSize = CGSize(width: width, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie = dao.searchResults[indexPath.row]
        if isSearching{movie = dao.filteredMovies[indexPath.row]}
        
        let movieVc = MovieViewController()
        movieVc.setMovie(movie: movie)
        movieVc.delegate = self
        dao.searchResults[indexPath.row] = movie
        self.present(movieVc, animated: true) 
        
    }
}
extension ListViewController:CellUpdate{
    func updateList() {
        self.collectionView.reloadData()
    }
    
    func refreshFavorite(indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at:indexPath) as? MovieCollectionViewCell{
            cell.refreshFavorite()
        }else {return}
        
        
    }
    
}

extension ListViewController:UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        collectionView.reloadData()
        searchBar.endEditing(true)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = searchBar.text{
            if text != ""{
                filterMovies(normalArray: dao.searchResults, filteredArray: dao.filteredMovies, name: text)
            }else{
                isSearching = false
                dao.filteredFavorites = []
                dao.filteredMovies = []
                collectionView.reloadData()
            }
        }else{
            isSearching = false
            dao.filteredFavorites = []
            dao.filteredMovies = []
            collectionView.reloadData()
        }
        searchBar.endEditing(true)
    }
    
    
    func filterMovies(normalArray:[Movie],filteredArray:[Movie],name:String){
        self.isSearching = true
        
        dao.filteredMovies = []
        
        let searchName = name.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
        let url = dao.searchURL + searchName
        
        let anonymousFunc = {(fetchedData:MovieSearch) in
            DispatchQueue.main.async {
                for movie in fetchedData.results{
                    dao.filteredMovies.append(movie)
                }
                debugPrint(dao.filteredMovies)
                self.collectionView.reloadData()
            }
        }
        api.movieSearch(urlStr: url , view: self, onCompletion: anonymousFunc)
    }
    
}


