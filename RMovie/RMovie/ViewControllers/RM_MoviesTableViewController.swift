//
//  RM_MoviesTableViewController.swift
//  RMovie
//
//  Created by Renato Mori on 04/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//
import Foundation
import UIKit

class RM_MoviesTableViewController: UITableViewController {
    
    var movies : RM_HTTP_Movies?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        self.movies = appDelegate.movies!;
        
        self.movies?.viewController = self;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (self.movies?.movies.count)!;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! RM_MovieTableViewCell;
        
        DispatchQueue.global(qos: .background).async {
        
            var movie : RM_Movie?;
            
            movie = self.movies?.getMovie(index: indexPath.row) ;
            
            DispatchQueue.main.async {
                cell.imgPoster.imageFromServerURL("https://image.tmdb.org/t/p/w500\(String((movie?.poster_path)!))", placeHolder:nil);
                
                cell.lblTitle.text = movie?.title;
                cell.lblYear.text = String((movie?.release_date?.prefix(4))!);
                cell.lblDescricao.text = movie?.overview;
                
            }
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        appDelegate.selectedIndex = indexPath.row;
    }
    
    
}
