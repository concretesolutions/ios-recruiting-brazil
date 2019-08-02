//
//  MoviesTabCollection.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 31/07/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import UIKit
import RealmSwift

protocol CollectionViewCellDelegate {
    func reloadView()
}

class MoviesTabCollection: UICollectionViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var movieInfoView: UIView!
    
    var id: Int = 0
    var viewCellDelegate: CollectionViewCellDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieImage.contentMode = .scaleToFill
        self.sendSubviewToBack(movieImage)
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        let realm = try! Realm()
        let objects = realm.objects(Movie.self)
        objects.forEach { (movie) in
            if(movie.id == self.id) {
                try! realm.write {
                    let updatedObject = movie
                    updatedObject.favorite = true
                    realm.add(updatedObject, update: .modified)
                    favoriteButton.imageView?.image = UIImage(named: "favorite_full_icon")
                    viewCellDelegate?.reloadView()
                }
            }
        }
    }
    

}
