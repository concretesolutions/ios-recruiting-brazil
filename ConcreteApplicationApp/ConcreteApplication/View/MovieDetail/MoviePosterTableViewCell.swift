//
//  MoviePosterTableViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 21/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

class MoviePosterTableViewCell: UITableViewCell, Reusable {


    lazy var poster: UIImageView = {
        let poster = UIImageView(frame: .zero)
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
    
    func setup(posterImage: UIImage){
        self.poster.image = posterImage
        setupView()
    }

}

extension MoviePosterTableViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(poster)
    }
    
    func setupConstraints() {
        
        poster.snp.makeConstraints { (make) in
            //FIXME:- change constraints if needed
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        poster.contentMode = .scaleAspectFit
    }
    
}
