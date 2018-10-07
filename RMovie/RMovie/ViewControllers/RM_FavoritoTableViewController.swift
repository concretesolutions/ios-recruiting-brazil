//
//  RM_FavoritoTableViewController.swift
//  RMovie
//
//  Created by Renato Mori on 07/10/18.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import UIKit

class RM_FavoritoTableViewController: UITableViewController , UISearchBarDelegate{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.srcBusca.delegate = self;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.tableView.reloadData();
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        appDelegate.moviesFilter = Favorite.store.moviesFilter;
    }
    //MARK: - Search
    
    @IBOutlet weak var srcBusca: UISearchBar!
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        Favorite.store.moviesFilter.titleSearch = searchText;
        Favorite.store.moviesFilter.applyFilters();
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(Favorite.store.moviesFilter.count!);
        return Favorite.store.moviesFilter.count!;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! RM_MovieTableViewCell;
        
        var movie : RM_Movie?;
        
        movie = Favorite.store.moviesFilter[indexPath.row];
        
        if(movie?.poster_path != nil){
            cell.imgPoster.imageFromServerURL("https://image.tmdb.org/t/p/w500\(String((movie?.poster_path)!))", placeHolder:nil);
        }else{
            cell.imgPoster.image = nil;
        }
        cell.lblTitle.text = movie?.title;
        cell.lblYear.text = String((movie?.release_date?.prefix(4))!);
        cell.lblDescricao.text = movie?.overview;
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        appDelegate.selectedMovie = Favorite.store.moviesFilter[indexPath.row];
    }
}
