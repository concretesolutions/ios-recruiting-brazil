//
//  MovieGridController.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 14/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

protocol SelectMovieDelegate {
    func didSelect(indexPath: IndexPath)
}

class MovieGridController: UIViewController {

    @IBOutlet weak var oContainerLabel: UILabel!
    @IBOutlet weak var oContainerImage: UIImageView!
    @IBOutlet weak var oCollectionImage: UIImageView!
    @IBOutlet weak var oContainerView: UIView!
    @IBOutlet weak var oSearchbar: UISearchBar!
    @IBOutlet weak var oCollectionView: UICollectionView!
    
    var movies: [Movie] = []
    var page = 1
    var selectedMovie: Movie?
    var filterdMovies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        oSearchbar.delegate = self
        oContainerView.isHidden = true
        self.oCollectionView.delegate = self
        self.oCollectionView.dataSource = self
        self.oCollectionView.reloadData()
        self.oCollectionView.isPrefetchingEnabled = true
        oCollectionView!.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.page = 1
        APIRequest.getMovies(inPage: page ) { (response) in
            switch response {
            case .success(let result as Result):
                self.movies = result.results
                self.filterdMovies = result.results
                break
            case .error(let error):
                print(error.description)
                break
            default:
                break
            }
            DispatchQueue.main.async {
                self.oCollectionView.reloadData()
            }
        }
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieInfoController {
            guard let selectedMovie = selectedMovie else {return}
            destination.movie = selectedMovie
        }
    }
    
}

extension MovieGridController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterdMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moviewGrid = MoviesGridCell()
        return moviewGrid.get(ofCollectionView: collectionView, withMovie: filterdMovies[indexPath.row], for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row >= movies.count - 10{
            self.page += 1
            APIRequest.getMovies(inPage: page ) { (response) in
                switch response {
                case .success(let result as Result):
                    self.movies.append(contentsOf: result.results)
                    self.filterdMovies = self.movies
                    break
                case .error(let error):
                    print(error.description)
                    break
                default:
                    break
                }
                DispatchQueue.main.async {
                    self.oCollectionView.reloadData()
                }
                
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedMovie = filterdMovies[indexPath.row]
        self.performSegue(withIdentifier: "toMovieInfo", sender: self)
    }
    
}

extension MovieGridController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterdMovies = movies
            self.oCollectionView.reloadData()
            oCollectionView.becomeFirstResponder()
            self.oContainerView.isHidden = true
            self.view.endEditing(true)
        }else{
            filterdMovies = movies
            filterdMovies =  filterdMovies.filter { (movie) -> Bool in
                return movie.original_title.lowercased().contains(searchText.lowercased())
            }
            if filterdMovies.isEmpty {
                self.oContainerView.isHidden = false
                oContainerImage.image = UIImage(named: "MoviesSearchEmptyState")
                oContainerLabel.text = "Sua busca por \"\(searchText)\" não resultou em nenhum resimageo"
                
            }else{
                self.oContainerView.isHidden = true
            }
            self.oCollectionView.reloadData()
        }
        
    }
}



