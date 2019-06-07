//
//  MovieTableViewCell.swift
//  GPSMovies
//
//  Created by Gilson Santos on 01/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import UIKit




class FavoriteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    public lazy var viewData = RatingViewData()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension FavoriteTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewData.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieElementCollectionViewCell", for: indexPath) as! MovieElementCollectionViewCell
        cell.prepareCell(viewData: self.viewData.movies[indexPath.row])
        return cell
    }
}

extension FavoriteTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension FavoriteTableViewCell {
    private func registerCell() {
        self.collectionView.register(UINib(nibName: "MovieElementCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieElementCollectionViewCell")
    }
    
    public func prepareCell(viewData: RatingViewData) {
        self.viewData = viewData
        self.labelTitle.text = viewData.labelRating
        self.collectionView.reloadData()
    }
}
