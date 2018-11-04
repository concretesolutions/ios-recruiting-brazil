//
//  FilterCollectionViewCell.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 03/11/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var filterLabel: UILabel!
    
    var genre:Genre?
    var year:String?
    var filterSelected:Bool = false
    
    func setGenre(g:Genre){
        genre = g
        year = nil
        filterLabel.text = g.name
        configCell()
    }
    
    func setYear(y:String){
        genre = nil
        year = y
        filterLabel.text = y
        configCell()
    }
    
    func configCell(){
        layer.cornerRadius = 3
        
        if(filterSelected){
            contentView.backgroundColor = UIColor(red:0.96, green:0.45, blue:0.00, alpha:1.0)
        }else{
            contentView.backgroundColor = UIColor(red:0.49, green:0.49, blue:0.49, alpha:1.0)
        }
        
    }
    
    
}
