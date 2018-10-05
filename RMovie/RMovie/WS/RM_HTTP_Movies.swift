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
    var movies : [RM_Movie?];
    var total_pages : NSInteger;
    var total_results : NSInteger;
    var viewController : UITableViewController?;
    
    override init() {
        self.ready = true;
        self.page = 0;
        self.movies = [];
        self.total_pages = 1;
        self.total_results = 0;
        super.init(method: "/movie/popular");
        getMore();
    }
    
    private func getMore(){
        self.ready = false;
        if(self.page < self.total_pages){
            self.page = self.page+1;
            super.get(params: "page=\(self.page)")
        }
    }
    
    override func callback(JSON: NSDictionary) {
        
        for json_movie in JSON.value(forKey: "results") as! NSArray{
            self.movies.append(RM_Movie(JSON: json_movie as! NSDictionary));
        }
        self.total_pages = JSON.value(forKey: "total_pages") as! NSInteger;
        self.total_results = JSON.value(forKey: "total_results") as! NSInteger;
        
        self.ready = true;
        
        
        DispatchQueue.main.async { self.viewController?.tableView.reloadData() }
    }
    
    func getMovie(index: NSInteger) -> RM_Movie?{
        
        if(index > self.movies.count-10 && self.movies.count < self.total_results && self.ready){
            getMore();
        }

        if(index < self.movies.count){
            return self.movies[index];
        }
        return nil;
    }
}
