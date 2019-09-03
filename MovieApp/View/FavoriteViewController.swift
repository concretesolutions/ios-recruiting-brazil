//
//  FavoriteViewController.swift
//  MovieAppTests
//
//  Created by Mac Pro on 30/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    let dataManager = DataManager()
    var array: [MovieFavorite] = []
    var selectedFavorite: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataManager.loadData { (arrayMovie) in
            if arrayMovie!.count > 0{
                self.array = arrayMovie!
                self.tableView.reloadData()
            }else{
                print("Ruim")
            }
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "favoriteSegue"{
            if let vc = segue.destination as? DetailsViewController{
                let ind = sender as! Int
                let movie = array[ind]
                
                let favMovie = Movie(idMovie: Int(movie.id), title: movie.title ?? "", posterPath: movie.url ?? "", backdropPath: movie.urlBackDrop, overview: movie.overview ?? "", releaseDate: movie.year ?? "")
                vc.movie = favMovie
            }
        }
    }
    
    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(UINib(nibName: "FavoriteCell", bundle: nil), forCellReuseIdentifier: "FavoriteCell")
        tableView.tableFooterView = UIView()
    }
}

extension FavoriteViewController: UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedFavorite = indexPath.row
        self.performSegue(withIdentifier: "favoriteSegue", sender: indexPath.item)
        print("Clidou no favorito")
    }
    
}

extension FavoriteViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteCell{
            cell.setCell(movie: array[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let movie = array[indexPath.row]
            let favMovie = Movie(idMovie: Int(movie.id), title: movie.title ?? "", posterPath: movie.url ?? "", backdropPath: movie.urlBackDrop, overview: movie.overview ?? "", releaseDate: movie.year ?? "")

            dataManager.deletePerson(movie: favMovie) { (success) in
                if success{
                    array.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .bottom)
                }else{
                    print("deu ruim")
                }
            }
            
        }
    }
    
}
