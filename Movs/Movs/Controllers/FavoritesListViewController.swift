//
//  FavoritesListViewController.swift
//  Movs
//
//  Created by vinicius emanuel on 16/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import UIKit
import Kingfisher

class FavoritesListViewController: UIViewController {
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var removeFilterButtonHight: NSLayoutConstraint!
    @IBOutlet weak var moviesTableView: UITableView!
    
    private let cellID = "movieCellID"
    private let segueID = "movieListToFilters"
    private var movies: [MovieModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadTableView()
    }
    
    @IBAction func removeFilterPressed(_ sender: Any) {
    }
    
    @IBAction func filterButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: self.segueID, sender: self)
    }
    
    func loadTableView(){
        LocalDataHelper.shared.getListOfSaveMovies { (movies) in
            self.movies = movies
            self.moviesTableView.reloadData()
        }
    }
    
}

extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! FavoMovieTableViewCell
        
        let movie = self.movies[indexPath.row]
        let paceholder = #imageLiteral(resourceName: "placeholder")
        if let url = URL(string: movie.posterURl){
            cell.moviePoster.kf.setImage(with: url, placeholder: paceholder)
        }else{
            cell.moviePoster.image = paceholder
        }
        
        cell.movieName.text = movie.title
        cell.movieSinopse.text = movie.sinopse
        cell.movieYear.text = movie.year
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let unfavorite = UITableViewRowAction(style: .destructive, title: "unfavorite") { (action, indexPath) in
            print(indexPath.row)
        }
        
        return [unfavorite]
    }
}
