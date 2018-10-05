//
//  RM_HTTP_Genres.swift
//  RMovie
//
//  Created by Renato Mori on 03/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation


class RM_HTTP_Genres : RM_HTTP{
    var genres : [NSInteger:String];
    
    
    override init() {
        self.genres = [NSInteger:String]();
        super.init(method: "/genre/movie/list")
        get(params: "")
    }
    
    override func callback(JSON: NSDictionary) {
        for genre in JSON.value(forKey: "genres") as! NSArray{
            let genre_dic = genre as! NSDictionary;
            let id = genre_dic.value(forKey: "id") as! NSInteger;
            let name = genre_dic.value(forKey: "name") as! String;
            self.genres[id] = name;
        }
    }
}
