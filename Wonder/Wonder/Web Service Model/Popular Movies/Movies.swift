//
//  Wonder
//  Movies
//
//  Created by Marcelo
//  Copyright © 2018 Marcelo. All rights reserved.
//


import Foundation

public class Movies {
    
	var page = Int()
	var total_results = Int()
	var total_pages = Int()
	var results = [Results]()
    
    
    init() {
        self.page = Int()
        self.total_results = Int()
        self.total_pages = Int()
        self.results = [Results]()
    }
    
    
    init(dictionary: NSDictionary) {
        if let page = dictionary["page"] as? Int {
            self.page = page
        }
        if let total_results = dictionary["total_results"] as? Int {
            self.total_results = total_results
        }
        if let total_pages = dictionary["total_pages"] as? Int {
            self.total_pages = total_pages
        }
        // results (the movie itself)
        let array = dictionary["results"] as! NSArray
        for item in array {
            let itemDic = item as! NSDictionary
            let article = Results(dictionary: itemDic)
            results.append(article)
        }
    }
    
}

