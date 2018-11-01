//
//  MovieGridCell.swift
//  Mov
//
//  Created by Miguel Nery on 27/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit
import SnapKit

class MovieGridCollectionViewCell: UICollectionViewCell {
    
    var movieGridUnit = MovieGridUnitView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieGridCollectionViewCell: ViewCode {
    func addView() {
        self.addSubview(self.movieGridUnit)
    }
    
    func addConstraints() {
        self.movieGridUnit.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}
