//
//  MoviesCell.swift
//  RecruitingChallenge
//
//  Created by Giovane Barreira on 11/30/19.
//  Copyright © 2019 Giovane Barreira. All rights reserved.
//

import UIKit

class MoviesCell: UICollectionViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    @IBAction func favoriteBtnTapped(_ sender: Any) {
        
    }
}



