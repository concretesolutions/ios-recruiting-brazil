//
//  MoviesTableViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit


class MoviesTableViewDataSource: NSObject, UITableViewDataSource {
    var datas = [NSDictionary]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTvCell") as! MoviesTableViewCell

        let movie = self.datas[indexPath.row]
        cell.label.text = movie[KeyAccesPropertiesMovieNowPlaying.title.value] as? String
        cell.imgMovie.image = movie[KeyAccesPropertiesMovieNowPlaying.posterPath.value] as? UIImage
        return cell
    }
    
}
