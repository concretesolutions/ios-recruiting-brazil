//
//  FavoriteController.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 23/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

class FavoriteController: UIViewController {

    @IBOutlet weak var oContainerLabel: UILabel!
    @IBOutlet weak var oContainerImage: UIImageView!
    @IBOutlet weak var oContainerView: UIView!
    @IBOutlet weak var oSearchBar: UISearchBar!
    @IBOutlet weak var oTableView: UITableView!
    var favorites: [Movie] = []
    var filterdMovies: [Movie] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        oTableView.delegate = self
        oTableView.dataSource = self
        oSearchBar.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        oContainerView.isHidden = true
        favorites = CoreDataManager.retriveData()
        filterdMovies = favorites
        oTableView.reloadData()
    }
}

extension FavoriteController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.filterdMovies = favorites
            self.oTableView.reloadData()
            oTableView.becomeFirstResponder()
            self.oTableView.isHidden = false
            oContainerView.isHidden = true
            self.view.endEditing(true)
        }else{
            filterdMovies = favorites
            filterdMovies = filterdMovies.filter { (movie) -> Bool in
                return movie.original_title.lowercased().contains(searchText.lowercased())
            }
            if filterdMovies.isEmpty {
                self.oTableView.isHidden = true
                oContainerView.isHidden = false
                oContainerImage.image = UIImage(named: "MoviesSearchEmptyState")
                oContainerLabel.text = "Sua busca por \"\(searchText)\" não resultou em nenhum resimageo"
            }else{
                self.oTableView.isHidden = false
                oContainerImage.isHidden = true
            }
            self.oTableView.reloadData()
        }
    }

}

extension FavoriteController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterdMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = FavoriteCell()
        return favoriteCell.get(ofTableView: self.oTableView, for: indexPath, movie: filterdMovies[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            CoreDataManager.deleteData(movie: filterdMovies[indexPath.row])
            favorites.remove(at: indexPath.row)
            oTableView.deleteRows(at: [indexPath], with: .fade)
            oTableView.reloadData()
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}

