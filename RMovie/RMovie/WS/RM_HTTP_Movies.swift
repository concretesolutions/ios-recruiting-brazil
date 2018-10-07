//
//  RM_HTTP_Movies.swift
//  RMovie
//
//  Created by Renato Mori on 03/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation
import UIKit

class RM_HTTP_Movies : RM_HTTP{
    var ready : Bool;
    var page : NSInteger;
//    var movies : [RM_Movie?];
    var total_pages : NSInteger;
    var total_results : NSInteger;
    var viewController : UITableViewController?;
    var moviesFilter : MovieFilter;
    
    override init() {
        self.ready = true;
        self.page = 0;
//        self.movies = [];
        self.total_pages = 1;
        self.total_results = 0;
        self.moviesFilter = MovieFilter(movies: []);
        super.init(method: "/movie/popular");
        getMore();
    }
    
    func getMore(){
        self.ready = false;
        if(self.page < self.total_pages){
            self.page = self.page+1;
            super.get(params: "page=\(self.page)")
        }
    }
    
    override func callback(JSON: NSDictionary) {
        
        for json_movie in JSON.value(forKey: "results") as! NSArray{
            self.moviesFilter.movies.append(RM_Movie(JSON: json_movie as! NSDictionary));
        }
        self.total_pages = JSON.value(forKey: "total_pages") as! NSInteger;
        self.total_results = JSON.value(forKey: "total_results") as! NSInteger;
        
        self.ready = true;
        self.moviesFilter.applyFilters();
        
        DispatchQueue.main.async { self.viewController?.tableView.reloadData() }
    }
    
    override func erroCallback(JSON: NSDictionary) {
        switch (JSON.value(forKey: "status_code") as! NSInteger){
        case 25://Your request count (#) is over the allowed limit of (40).
            DispatchQueue.global(qos: .background).async {
                sleep(1);
                self.ready = true;
            }
        default:
            print(JSON);
            self.ready = true;
        }
    }
    
    func getMovie(index: NSInteger) -> RM_Movie?{
        if(index > (self.moviesFilter.count)!-2 && self.moviesFilter.movies.count < self.total_results && self.ready){
            getMore();
        }
        
        if(index < (self.moviesFilter.count)!){
            return self.moviesFilter[index];
        }
        return nil;
    }
    
    
}
