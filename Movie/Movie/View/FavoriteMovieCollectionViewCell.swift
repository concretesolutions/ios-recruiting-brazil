//
//  FavoriteMovieCollectionViewCell.swift
//  Movie
//
//  Created by Gustavo Pereira Teixeira Quenca on 19/07/19.
//  Copyright © 2019 Gustavo Pereira Teixeira Quenca. All rights reserved.
//

import UIKit

class FavoriteMovieCollectionViewCell: UICollectionViewCell {

    var downloadTask: URLSessionDownloadTask?
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: -Configure the view for Favorites Movies
    func configure(for result: NSObject) {
        
        if let title = result.value(forKeyPath: "title") as? String {
            titleLabel.text = title
        }
        
        if let data = result.value(forKeyPath: "posterPath") as? NSData {
            posterImage.image = UIImage(data: data as Data)
        }
        
        if let year = result.value(forKeyPath: "year") as? String {
            // Show only the year
            let index = year.index(year.startIndex, offsetBy: 4)
            yearLabel.text = String(year.prefix(upTo: index))
        } else {
            yearLabel.text = "No Results"
        }
    }
}
