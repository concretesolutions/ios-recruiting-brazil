//
//  MovieCollectionViewCell.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    //MARK: - Init methods
    func setUp(imageName:String){
           self.poster.layer.masksToBounds = true
           updatePosterImage(cell: self, imageUrl: imageName)
       }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        safeArea = layoutMarginsGuide
        setContraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Complimentary Methods
    //This function updates the cell`s poster image, accordingly to its url
    private func updatePosterImage(cell:MovieCollectionViewCell,imageUrl:String){
              let url = "https://image.tmdb.org/t/p/w500\(imageUrl)"
              let anonymousFunc = {(fetchedData:UIImage) in
                      DispatchQueue.main.async {
                       cell.poster.image = fetchedData
                      }
                  }
              api.retrieveImage(urlStr: url, onCompletion: anonymousFunc)
              }
    
    func setContraints(){
        poster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        poster.setContentHuggingPriority(.defaultHigh, for: .vertical)
        
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }  
}
