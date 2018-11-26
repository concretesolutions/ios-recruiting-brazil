//
//  MoviewCollectionViewCell.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 17/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//

import UIKit

protocol MovieCollectionViewCellDelegate:class {
    func didTap(isFavorited:Bool, in cell:MovieCollectionViewCell)
}

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    // MARK: Private
    private var imagePath:String!
    private var isFavorited = false
    // MARK: Public
    @IBOutlet weak var outletMovieLabel:UILabel!
    @IBOutlet weak var outletMovieImage:UIImageView!
    @IBOutlet weak var outletFavoriteButton: UIButton!
    
    weak var delegate:MovieCollectionViewCellDelegate?
    
    // MARK: - UICollectionViewCell
    override func awakeFromNib() {
        self.setupViews()
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setupViews() {
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.cornerRadius = 10.0
        
        
//        let ratio:CGFloat = 0.90
//        let rect = CGRect(x: (self.bounds.width*(1-ratio))/2, y: (self.bounds.height*(1-ratio))/2, width: self.bounds.width*ratio, height: self.bounds.height*ratio)
//        self.layer.shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: self.contentView.layer.cornerRadius).cgPath
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        self.layer.shadowOpacity = 0.8
//        self.layer.shadowRadius = 5
//        self.layer.masksToBounds = false
        
        self.contentView.clipsToBounds = true
    }
    
    // MARK: Public
    func cleanData() {
        self.outletMovieImage.image = #imageLiteral(resourceName: "default-Movie")
        self.outletMovieLabel.text = "Loading ..."
    }
    
    func set(name: String?){
        self.outletMovieLabel.text = name ?? "No Title"
    }
    
    func set(imagePath: String?){
        
        guard let imagePathValidated = imagePath else {
            Logger.logError(in: self, message: "Could not get instance from imagePath:\(imagePath ?? "Nil")")
            return
        }
        
        self.imagePath = imagePathValidated
        
        ImageManager.shared.fetchImage(from: imagePathValidated) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if self.imagePath == imagePathValidated {
                        self.outletMovieImage.image = data
                    }else{
                        self.outletMovieImage.image = #imageLiteral(resourceName: "default-Movie")
                    }
                }
            case .failure(let error):
                Logger.logError(in: self, message: error.localizedDescription)
                DispatchQueue.main.async {
                    self.outletMovieImage.image = #imageLiteral(resourceName: "default-Movie")
                }
            }
        }
    }
    
    func set(isFavorite:Bool) {
        self.isFavorited = isFavorite
        switch self.isFavorited {
        case true:
            self.outletFavoriteButton.setImage(#imageLiteral(resourceName: "favorite_full_icon"), for: .normal)
        case false:
            self.outletFavoriteButton.setImage(#imageLiteral(resourceName: "favorite_empty_icon"), for: .normal)
        }
    }
    
    // MARK: - IBActions
    @IBAction func tapFavorite(_ sender: UIButton) {
        self.set(isFavorite: !self.isFavorited)
        self.delegate?.didTap(isFavorited: self.isFavorited, in: self)
    }
}
