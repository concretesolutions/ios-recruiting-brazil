//
//  FavoritesListViewController.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import UIKit

class FavoritesListViewController: UIViewController {
    //MARK: Properties
    var presenter:ViewToFavoritesListPresenterProtocol?
    //MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var viewContent: UIView!
    @IBOutlet weak var display: DisplayInformationView!
    //MARK:Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        FavoritesListRouter.setModule(self)
        self.searchBar.styleDefault()
        self.navigationController?.navigationBar.styleDefault()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoritesListViewController: PresenterToFavoritesListViewProtocol {
    func returnMovies(movies: [MovieListData], moviesTotal: Int) {
        
    }
    
    func returnMoviesError(message: String) {
        
    }
    
    func returnLoadGenrers(genres: [GenreData]) {
        
    }
    
    func returnLoadGenrersError(message: String) {
        
    }
    
    
}
